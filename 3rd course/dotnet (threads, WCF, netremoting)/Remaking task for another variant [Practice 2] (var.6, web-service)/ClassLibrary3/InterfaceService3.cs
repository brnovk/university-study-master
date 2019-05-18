using System.ServiceModel;

namespace ClassLibrary3
{
    [ServiceContract]
    public interface InterfaceService3
    {
        [OperationContract]
        string Transliteration(string s1);

        [OperationContract]
        string AppointmentPlugin();
    }
}
