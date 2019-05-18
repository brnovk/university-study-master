using System;
using System.ServiceModel;
using System.ServiceModel.Description;

using ClassLibrary1;
using ClassLibrary2;
using ClassLibrary3;
using ClassLibrary4;

namespace HostApplication
{
    class Program
    {
        static void Main(string[] args)
        {
            Uri baseAddress1 = new Uri("http://localhost:46444/Service1.svc");
            ServiceHost host1 = new ServiceHost(typeof(Service1), baseAddress1);
            ServiceMetadataBehavior smb1 = new ServiceMetadataBehavior();
            smb1.HttpGetEnabled = true;
            smb1.MetadataExporter.PolicyVersion = PolicyVersion.Policy15;
            host1.Description.Behaviors.Add(smb1);
            host1.Open();

            Uri baseAddress2 = new Uri("http://localhost:46444/Service2.svc");
            ServiceHost host2 = new ServiceHost(typeof(Service2), baseAddress2);
            ServiceMetadataBehavior smb2 = new ServiceMetadataBehavior();
            smb2.HttpGetEnabled = true;
            smb2.MetadataExporter.PolicyVersion = PolicyVersion.Policy15;
            host2.Description.Behaviors.Add(smb2);
            host2.Open();

            Uri baseAddress3 = new Uri("http://localhost:46444/Service3.svc");
            ServiceHost host3 = new ServiceHost(typeof(Service3), baseAddress3);
            ServiceMetadataBehavior smb3 = new ServiceMetadataBehavior();
            smb3.HttpGetEnabled = true;
            smb3.MetadataExporter.PolicyVersion = PolicyVersion.Policy15;
            host3.Description.Behaviors.Add(smb3);
            host3.Open();

            Uri baseAddress4 = new Uri("http://localhost:46444/Service4.svc");
            ServiceHost host4 = new ServiceHost(typeof(Service4), baseAddress4);
            ServiceMetadataBehavior smb4 = new ServiceMetadataBehavior();
            smb4.HttpGetEnabled = true;
            smb4.MetadataExporter.PolicyVersion = PolicyVersion.Policy15;
            host4.Description.Behaviors.Add(smb4);
            host4.Open();

            Console.WriteLine("The service is ready at {0}", baseAddress1);
            Console.WriteLine("The service is ready at {0}", baseAddress2);
            Console.WriteLine("The service is ready at {0}", baseAddress3);
            Console.WriteLine("The service is ready at {0}", baseAddress4);
            Console.WriteLine("Press <Enter> to stop the service.");
            Console.ReadLine();

            host1.Close();
            host2.Close();
            host3.Close();
            host4.Close();
        }
    }
}
