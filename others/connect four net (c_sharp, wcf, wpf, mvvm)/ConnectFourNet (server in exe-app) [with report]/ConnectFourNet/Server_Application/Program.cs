using System;
using System.ServiceModel;
using ConnectNNet.Server;

namespace ConnectNNet.Server_Host
{
	static class Program
	{
		static void Main(string[] args)
		{
			Console.WriteLine("Запуск сервера...");
			
			try
			{
				ServiceHost server = new ServiceHost(typeof(WcfServer));
				server.Open();
				Console.WriteLine("Сервер запущен.");
			}
			catch (Exception e)
			{
				Console.WriteLine(e.Message);
			}
			Console.ReadKey();
		}
	}
}
