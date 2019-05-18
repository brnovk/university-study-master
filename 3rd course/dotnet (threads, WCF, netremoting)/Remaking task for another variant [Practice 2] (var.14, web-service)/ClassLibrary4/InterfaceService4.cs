using System.ServiceModel;

namespace ClassLibrary4
{
    [ServiceContract]
    public interface InterfaceService4
    {
        [OperationContract]
        bool CheckingForDivisibilityByTen(int number);

        [OperationContract]
        string AppointmentPlugin();
    }
}
