using System.ServiceModel;

namespace ClassLibrary1
{
    [ServiceContract]
    public interface InterfaceService1
    {
        [OperationContract]
        string AdditionOctalNumbers(string s1, string s2);

        [OperationContract]
        string AppointmentPlugin();
    }
}
