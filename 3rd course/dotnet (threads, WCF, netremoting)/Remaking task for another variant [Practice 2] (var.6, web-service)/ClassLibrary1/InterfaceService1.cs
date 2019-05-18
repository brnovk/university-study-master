using System.ServiceModel;

namespace ClassLibrary1
{
    [ServiceContract]
    public interface InterfaceService1
    {
        [OperationContract]
        string ReverseString(string s);

        [OperationContract]
        string AppointmentPlugin();
    }
}
