using System.ServiceModel;

namespace ClassLibrary1
{
    [ServiceContract]
    public interface InterfaceService1
    {
        [OperationContract]
        bool CheckingForDivisibilityByTwo(int number);

        [OperationContract]
        string AppointmentPlugin();
    }
}
