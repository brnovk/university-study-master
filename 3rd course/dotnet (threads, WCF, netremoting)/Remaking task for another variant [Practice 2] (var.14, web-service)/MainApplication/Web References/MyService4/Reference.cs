﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан программой.
//     Исполняемая версия:4.0.30319.19408
//
//     Изменения в этом файле могут привести к неправильной работе и будут потеряны в случае
//     повторной генерации кода.
// </auto-generated>
//------------------------------------------------------------------------------

// 
// Этот исходный текст был создан автоматически: Microsoft.VSDesigner, версия: 4.0.30319.19408.
// 
#pragma warning disable 1591

namespace MainApplication.MyService4 {
    using System;
    using System.Web.Services;
    using System.Diagnostics;
    using System.Web.Services.Protocols;
    using System.Xml.Serialization;
    using System.ComponentModel;
    
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.19408")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Web.Services.WebServiceBindingAttribute(Name="BasicHttpBinding_InterfaceService4", Namespace="http://tempuri.org/")]
    public partial class Service4 : System.Web.Services.Protocols.SoapHttpClientProtocol {
        
        private System.Threading.SendOrPostCallback CheckingForDivisibilityByTenOperationCompleted;
        
        private System.Threading.SendOrPostCallback AppointmentPluginOperationCompleted;
        
        private bool useDefaultCredentialsSetExplicitly;
        
        /// <remarks/>
        public Service4() {
            this.Url = global::MainApplication.Properties.Settings.Default.MainApplication_MyService4_Service4;
            if ((this.IsLocalFileSystemWebService(this.Url) == true)) {
                this.UseDefaultCredentials = true;
                this.useDefaultCredentialsSetExplicitly = false;
            }
            else {
                this.useDefaultCredentialsSetExplicitly = true;
            }
        }
        
        public new string Url {
            get {
                return base.Url;
            }
            set {
                if ((((this.IsLocalFileSystemWebService(base.Url) == true) 
                            && (this.useDefaultCredentialsSetExplicitly == false)) 
                            && (this.IsLocalFileSystemWebService(value) == false))) {
                    base.UseDefaultCredentials = false;
                }
                base.Url = value;
            }
        }
        
        public new bool UseDefaultCredentials {
            get {
                return base.UseDefaultCredentials;
            }
            set {
                base.UseDefaultCredentials = value;
                this.useDefaultCredentialsSetExplicitly = true;
            }
        }
        
        /// <remarks/>
        public event CheckingForDivisibilityByTenCompletedEventHandler CheckingForDivisibilityByTenCompleted;
        
        /// <remarks/>
        public event AppointmentPluginCompletedEventHandler AppointmentPluginCompleted;
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/InterfaceService4/CheckingForDivisibilityByTen", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public void CheckingForDivisibilityByTen(int number, [System.Xml.Serialization.XmlIgnoreAttribute()] bool numberSpecified, out bool CheckingForDivisibilityByTenResult, [System.Xml.Serialization.XmlIgnoreAttribute()] out bool CheckingForDivisibilityByTenResultSpecified) {
            object[] results = this.Invoke("CheckingForDivisibilityByTen", new object[] {
                        number,
                        numberSpecified});
            CheckingForDivisibilityByTenResult = ((bool)(results[0]));
            CheckingForDivisibilityByTenResultSpecified = ((bool)(results[1]));
        }
        
        /// <remarks/>
        public void CheckingForDivisibilityByTenAsync(int number, bool numberSpecified) {
            this.CheckingForDivisibilityByTenAsync(number, numberSpecified, null);
        }
        
        /// <remarks/>
        public void CheckingForDivisibilityByTenAsync(int number, bool numberSpecified, object userState) {
            if ((this.CheckingForDivisibilityByTenOperationCompleted == null)) {
                this.CheckingForDivisibilityByTenOperationCompleted = new System.Threading.SendOrPostCallback(this.OnCheckingForDivisibilityByTenOperationCompleted);
            }
            this.InvokeAsync("CheckingForDivisibilityByTen", new object[] {
                        number,
                        numberSpecified}, this.CheckingForDivisibilityByTenOperationCompleted, userState);
        }
        
        private void OnCheckingForDivisibilityByTenOperationCompleted(object arg) {
            if ((this.CheckingForDivisibilityByTenCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.CheckingForDivisibilityByTenCompleted(this, new CheckingForDivisibilityByTenCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/InterfaceService4/AppointmentPlugin", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        [return: System.Xml.Serialization.XmlElementAttribute(IsNullable=true)]
        public string AppointmentPlugin() {
            object[] results = this.Invoke("AppointmentPlugin", new object[0]);
            return ((string)(results[0]));
        }
        
        /// <remarks/>
        public void AppointmentPluginAsync() {
            this.AppointmentPluginAsync(null);
        }
        
        /// <remarks/>
        public void AppointmentPluginAsync(object userState) {
            if ((this.AppointmentPluginOperationCompleted == null)) {
                this.AppointmentPluginOperationCompleted = new System.Threading.SendOrPostCallback(this.OnAppointmentPluginOperationCompleted);
            }
            this.InvokeAsync("AppointmentPlugin", new object[0], this.AppointmentPluginOperationCompleted, userState);
        }
        
        private void OnAppointmentPluginOperationCompleted(object arg) {
            if ((this.AppointmentPluginCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.AppointmentPluginCompleted(this, new AppointmentPluginCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        public new void CancelAsync(object userState) {
            base.CancelAsync(userState);
        }
        
        private bool IsLocalFileSystemWebService(string url) {
            if (((url == null) 
                        || (url == string.Empty))) {
                return false;
            }
            System.Uri wsUri = new System.Uri(url);
            if (((wsUri.Port >= 1024) 
                        && (string.Compare(wsUri.Host, "localHost", System.StringComparison.OrdinalIgnoreCase) == 0))) {
                return true;
            }
            return false;
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.19408")]
    public delegate void CheckingForDivisibilityByTenCompletedEventHandler(object sender, CheckingForDivisibilityByTenCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.19408")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class CheckingForDivisibilityByTenCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal CheckingForDivisibilityByTenCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public bool CheckingForDivisibilityByTenResult {
            get {
                this.RaiseExceptionIfNecessary();
                return ((bool)(this.results[0]));
            }
        }
        
        /// <remarks/>
        public bool CheckingForDivisibilityByTenResultSpecified {
            get {
                this.RaiseExceptionIfNecessary();
                return ((bool)(this.results[1]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.19408")]
    public delegate void AppointmentPluginCompletedEventHandler(object sender, AppointmentPluginCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.19408")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class AppointmentPluginCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal AppointmentPluginCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public string Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((string)(this.results[0]));
            }
        }
    }
}

#pragma warning restore 1591