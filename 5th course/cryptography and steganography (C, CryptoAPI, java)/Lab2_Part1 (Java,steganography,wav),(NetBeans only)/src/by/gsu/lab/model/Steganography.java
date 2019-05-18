package by.gsu.lab.model;

import by.gsu.lab.exceptions.SteganographyException;

/**
 * @author Viktor Baranov
 */
public class Steganography {

    public Steganography() {
    }

    private byte[] bitConversion(int i) {
        byte byte3 = (byte)((i & 0xFF000000) >>> 24);
        byte byte2 = (byte)((i & 0x00FF0000) >>> 16);
        byte byte1 = (byte)((i & 0x0000FF00) >>> 8 );
        byte byte0 = (byte)((i & 0x000000FF)       );
        return(new byte[]{byte3,byte2,byte1,byte0});
    }
    
    private byte[] encodeText(byte[] sourceWav, byte[] addition, int offset) 
            throws SteganographyException, RuntimeException {
        
        //check that the data + offset will fit in the sourceWav
        if(addition.length + offset > sourceWav.length) {
            throw new SteganographyException("File not long enough!");
        }
        
        //loop through each addition byt
        for(int i=0; i < addition.length; ++i) {
            
            //loop through the 8 bits of each byte
            int add = addition[i];
            
            //ensure the new offset value carries on through both loops
            for(int bit=7; bit>=0; --bit, ++offset) {
                //assign an integer to b, shifted by bit spaces AND 1
                //a single bit of the current byte
                int b = (add >>> bit) & 1;
                //assign the bit by taking: [(previous byte value) AND 0xfe] 
                // OR bit to add changes the last bit of the byte in the 
                //sourceWav to be the bit of addition
                sourceWav[offset] = (byte)((sourceWav[offset] & 0xFE ) | b );
            }
        }
        return sourceWav;
    }
    
    public void addTextToData(byte[] data, String text) 
            throws SteganographyException, RuntimeException {
        
        byte msg[] = text.getBytes();
        byte len[] = bitConversion(msg.length);
        
        //0 first positiong
        encodeText(data, len,  0);
        
        //4 bytes of space for length: 4bytes*8bit = 32 bits
        encodeText(data, msg, 32);
    }

    public String getTextFromData(byte[] sourceWav) {
        int length = 0;
        int offset = 32;
        
        //loop through 32 bytes of data to determine text length
        for(int i=0; i<32; ++i) {
            length = (length << 1) | (sourceWav[i] & 1);
        }
        
        byte[] result = new byte[length];
        
        //loop through each byte of text
        for(int b=0; b<result.length; ++b) {
            
            //loop through each bit within a byte of text
            for(int i=0; i<8; ++i, ++offset) {
                
                //assign bit: [(new byte value) << 1] OR [(text byte) AND 1]
                result[b] = (byte)((result[b] << 1) | (sourceWav[offset] & 1));
            }
        }
        return new String(result);
    }
}