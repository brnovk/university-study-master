using System.ServiceModel;

namespace ClassLibrary2
{
    [ServiceContract]
    public interface InterfaceService2
    {
        [OperationContract]
        bool CheckingForDivisibilityByThree(int number);

        [OperationContract]
        string AppointmentPlugin();
    }
}
