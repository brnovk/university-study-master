using System.ServiceModel;

namespace ClassLibrary3
{
    [ServiceContract]
    public interface InterfaceService3
    {
        [OperationContract]
        string MultiplicationOctalNumbers(string s1, string s2);

        [OperationContract]
        string AppointmentPlugin();
    }
}
