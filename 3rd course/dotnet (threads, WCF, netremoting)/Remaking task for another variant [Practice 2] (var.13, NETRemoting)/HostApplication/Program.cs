using System;
using System.Runtime.Remoting.Channels.Ipc;
using System.Security.Permissions;

namespace HostApplication
{
    class Program
    {
        [SecurityPermission(SecurityAction.Demand)]
        static void Main(string[] args)
        {
            IpcChannel serverChannel = new IpcChannel("localhost:9090"); // Создаём канал сервера

            // Регистрируем канал сервера
            System.Runtime.Remoting.Channels.ChannelServices.RegisterChannel(serverChannel, false);

            // Обьявляем объекты для удаленных вызовов.
            System.Runtime.Remoting.RemotingConfiguration.
                RegisterWellKnownServiceType(typeof(ClassLibrary1.Class1), "RemoteObject1.rem",
                                            System.Runtime.Remoting.WellKnownObjectMode.Singleton);
            System.Runtime.Remoting.RemotingConfiguration.
                RegisterWellKnownServiceType(typeof(ClassLibrary2.Class2), "RemoteObject2.rem",
                                            System.Runtime.Remoting.WellKnownObjectMode.Singleton);
            System.Runtime.Remoting.RemotingConfiguration.
                RegisterWellKnownServiceType(typeof(ClassLibrary3.Class3), "RemoteObject3.rem",
                                            System.Runtime.Remoting.WellKnownObjectMode.Singleton);
            System.Runtime.Remoting.RemotingConfiguration.
                RegisterWellKnownServiceType(typeof(ClassLibrary4.Class4), "RemoteObject4.rem",
                                            System.Runtime.Remoting.WellKnownObjectMode.Singleton);
            System.Runtime.Remoting.RemotingConfiguration.
                RegisterWellKnownServiceType(typeof(ClassLibrary5.Class5), "RemoteObject5.rem",
                                            System.Runtime.Remoting.WellKnownObjectMode.Singleton);

            // Ожидаем реакции пользователя.
            Console.WriteLine("Хост приложение запущено.\nВ этом окне будут отображен список всех"
                + " запущенных методов. ");
            Console.WriteLine("Нажмите любую кнопку для завершения...\n");
            Console.ReadLine();
        }
    }
}
