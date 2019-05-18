using System.ServiceModel;

namespace ClassLibrary2
{
    [ServiceContract]
    public interface InterfaceService2
    {
        [OperationContract]
        string DifferenceOctalNumbers(string s1, string s2);

        [OperationContract]
        string AppointmentPlugin();
    }
}
