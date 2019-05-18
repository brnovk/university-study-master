using System.ServiceModel;

namespace ClassLibrary2
{
    [ServiceContract]
    public interface InterfaceService2
    {
        [OperationContract]
        string Shift(string s1);

        [OperationContract]
        string AppointmentPlugin();
    }
}
