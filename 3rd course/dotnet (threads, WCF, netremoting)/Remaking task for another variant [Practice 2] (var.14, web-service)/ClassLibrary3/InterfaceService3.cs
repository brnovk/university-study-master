using System.ServiceModel;

namespace ClassLibrary3
{
    [ServiceContract]
    public interface InterfaceService3
    {
        [OperationContract]
        bool CheckingForDivisibilityByFive(int number);

        [OperationContract]
        string AppointmentPlugin();
    }
}
