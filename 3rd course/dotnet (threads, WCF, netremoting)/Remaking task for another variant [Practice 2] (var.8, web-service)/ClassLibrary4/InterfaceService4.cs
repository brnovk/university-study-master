using System.ServiceModel;

namespace ClassLibrary4
{
    [ServiceContract]
    public interface InterfaceService4
    {
        [OperationContract]
        string ModuloOctalNumbers(string s1, string s2);

        [OperationContract]
        string AppointmentPlugin();
    }
}
