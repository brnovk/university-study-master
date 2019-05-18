namespace ScheduleWriter.View.Impls {

    partial class MainWindow {

        /// <summary>
        /// Требуется переменная конструктора.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Освободить все используемые ресурсы.
        /// </summary>
        /// <param name="disposing">истинно, если управляемый ресурс должен быть удален; иначе ложно.</param>
        protected override void Dispose(bool disposing) {
            if (disposing && (components != null)) {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Код, автоматически созданный конструктором форм Windows

        /// <summary>
        /// Обязательный метод для поддержки конструктора - не изменяйте
        /// содержимое данного метода при помощи редактора кода.
        /// </summary>
        private void InitializeComponent() {
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle4 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle5 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle6 = new System.Windows.Forms.DataGridViewCellStyle();
            this.mainGrid = new System.Windows.Forms.DataGridView();
            this.gridPanel = new System.Windows.Forms.Panel();
            this.actionCellPanel = new System.Windows.Forms.Panel();
            this.actionCellAddEdit = new System.Windows.Forms.Button();
            this.actionCellCopy = new System.Windows.Forms.Button();
            this.actionCellPaste = new System.Windows.Forms.Button();
            this.actionCellDelete = new System.Windows.Forms.Button();
            this.mainMenu = new System.Windows.Forms.MenuStrip();
            this.menuToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.tableLayoutPanel = new System.Windows.Forms.TableLayoutPanel();
            this.groupList = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.mainGrid)).BeginInit();
            this.gridPanel.SuspendLayout();
            this.actionCellPanel.SuspendLayout();
            this.mainMenu.SuspendLayout();
            this.tableLayoutPanel.SuspendLayout();
            this.SuspendLayout();
            // 
            // mainGrid
            // 
            this.mainGrid.AllowUserToResizeColumns = false;
            this.mainGrid.AllowUserToResizeRows = false;
            this.mainGrid.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            dataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle4.BackColor = System.Drawing.Color.White;
            dataGridViewCellStyle4.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            dataGridViewCellStyle4.ForeColor = System.Drawing.Color.Black;
            dataGridViewCellStyle4.SelectionBackColor = System.Drawing.Color.White;
            dataGridViewCellStyle4.SelectionForeColor = System.Drawing.Color.Black;
            dataGridViewCellStyle4.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.mainGrid.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle4;
            this.mainGrid.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.mainGrid.ColumnHeadersVisible = false;
            dataGridViewCellStyle5.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle5.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle5.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            dataGridViewCellStyle5.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle5.SelectionBackColor = System.Drawing.Color.Transparent;
            dataGridViewCellStyle5.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle5.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.mainGrid.DefaultCellStyle = dataGridViewCellStyle5;
            this.mainGrid.Dock = System.Windows.Forms.DockStyle.Fill;
            this.mainGrid.GridColor = System.Drawing.SystemColors.ControlDarkDark;
            this.mainGrid.Location = new System.Drawing.Point(0, 0);
            this.mainGrid.Margin = new System.Windows.Forms.Padding(0);
            this.mainGrid.Name = "mainGrid";
            this.mainGrid.RowHeadersVisible = false;
            this.mainGrid.RowHeadersWidth = 29;
            dataGridViewCellStyle6.BackColor = System.Drawing.Color.White;
            dataGridViewCellStyle6.ForeColor = System.Drawing.Color.Black;
            dataGridViewCellStyle6.SelectionBackColor = System.Drawing.Color.White;
            dataGridViewCellStyle6.SelectionForeColor = System.Drawing.Color.Black;
            this.mainGrid.RowsDefaultCellStyle = dataGridViewCellStyle6;
            this.mainGrid.Size = new System.Drawing.Size(1018, 523);
            this.mainGrid.TabIndex = 0;
            this.mainGrid.CellMouseMove += new System.Windows.Forms.DataGridViewCellMouseEventHandler(this.mainGrid_CellMouseMove);
            this.mainGrid.Paint += new System.Windows.Forms.PaintEventHandler(this.mainGrid_Paint);
            // 
            // gridPanel
            // 
            this.gridPanel.Controls.Add(this.mainGrid);
            this.gridPanel.Controls.Add(this.actionCellPanel);
            this.gridPanel.Dock = System.Windows.Forms.DockStyle.Fill;
            this.gridPanel.Location = new System.Drawing.Point(3, 3);
            this.gridPanel.Name = "gridPanel";
            this.gridPanel.Size = new System.Drawing.Size(1018, 523);
            this.gridPanel.TabIndex = 8;
            // 
            // actionCellPanel
            // 
            this.actionCellPanel.Controls.Add(this.actionCellAddEdit);
            this.actionCellPanel.Controls.Add(this.actionCellCopy);
            this.actionCellPanel.Controls.Add(this.actionCellPaste);
            this.actionCellPanel.Controls.Add(this.actionCellDelete);
            this.actionCellPanel.Location = new System.Drawing.Point(950, 560);
            this.actionCellPanel.Name = "actionCellPanel";
            this.actionCellPanel.Size = new System.Drawing.Size(89, 20);
            this.actionCellPanel.TabIndex = 1;
            // 
            // actionCellAddEdit
            // 
            this.actionCellAddEdit.Location = new System.Drawing.Point(0, 0);
            this.actionCellAddEdit.Margin = new System.Windows.Forms.Padding(0);
            this.actionCellAddEdit.Name = "actionCellAddEdit";
            this.actionCellAddEdit.Size = new System.Drawing.Size(20, 20);
            this.actionCellAddEdit.TabIndex = 2;
            this.actionCellAddEdit.Text = "+";
            this.actionCellAddEdit.UseVisualStyleBackColor = true;
            this.actionCellAddEdit.Click += new System.EventHandler(this.actionCellAddEdit_Click);
            // 
            // actionCellCopy
            // 
            this.actionCellCopy.Location = new System.Drawing.Point(23, 0);
            this.actionCellCopy.Name = "actionCellCopy";
            this.actionCellCopy.Size = new System.Drawing.Size(20, 20);
            this.actionCellCopy.TabIndex = 3;
            this.actionCellCopy.Text = "C";
            this.actionCellCopy.UseVisualStyleBackColor = true;
            this.actionCellCopy.Click += new System.EventHandler(this.actionCellCopy_Click);
            // 
            // actionCellPaste
            // 
            this.actionCellPaste.Location = new System.Drawing.Point(46, 0);
            this.actionCellPaste.Name = "actionCellPaste";
            this.actionCellPaste.Size = new System.Drawing.Size(20, 20);
            this.actionCellPaste.TabIndex = 4;
            this.actionCellPaste.Text = "P";
            this.actionCellPaste.UseVisualStyleBackColor = true;
            this.actionCellPaste.Click += new System.EventHandler(this.actionCellPaste_Click);
            // 
            // actionCellDelete
            // 
            this.actionCellDelete.Location = new System.Drawing.Point(69, 0);
            this.actionCellDelete.Name = "actionCellDelete";
            this.actionCellDelete.Size = new System.Drawing.Size(20, 20);
            this.actionCellDelete.TabIndex = 5;
            this.actionCellDelete.Text = "D";
            this.actionCellDelete.UseVisualStyleBackColor = true;
            this.actionCellDelete.Click += new System.EventHandler(this.actionCellDelete_Click);
            // 
            // mainMenu
            // 
            this.mainMenu.GripMargin = new System.Windows.Forms.Padding(0);
            this.mainMenu.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.menuToolStripMenuItem});
            this.mainMenu.Location = new System.Drawing.Point(0, 0);
            this.mainMenu.Name = "mainMenu";
            this.mainMenu.Padding = new System.Windows.Forms.Padding(6, 0, 0, 0);
            this.mainMenu.Size = new System.Drawing.Size(1024, 24);
            this.mainMenu.TabIndex = 6;
            this.mainMenu.Text = "mainMenu";
            // 
            // menuToolStripMenuItem
            // 
            this.menuToolStripMenuItem.Name = "menuToolStripMenuItem";
            this.menuToolStripMenuItem.Size = new System.Drawing.Size(50, 24);
            this.menuToolStripMenuItem.Text = "Menu";
            // 
            // tableLayoutPanel
            // 
            this.tableLayoutPanel.ColumnCount = 1;
            this.tableLayoutPanel.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel.Controls.Add(this.gridPanel, 0, 0);
            this.tableLayoutPanel.Controls.Add(this.groupList, 0, 1);
            this.tableLayoutPanel.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel.Location = new System.Drawing.Point(0, 24);
            this.tableLayoutPanel.Name = "tableLayoutPanel";
            this.tableLayoutPanel.RowCount = 2;
            this.tableLayoutPanel.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.tableLayoutPanel.Size = new System.Drawing.Size(1024, 552);
            this.tableLayoutPanel.TabIndex = 7;
            // 
            // groupList
            // 
            this.groupList.Location = new System.Drawing.Point(3, 529);
            this.groupList.Margin = new System.Windows.Forms.Padding(3, 0, 3, 0);
            this.groupList.Name = "groupList";
            this.groupList.Size = new System.Drawing.Size(75, 23);
            this.groupList.TabIndex = 8;
            this.groupList.Text = "Список групп";
            this.groupList.UseVisualStyleBackColor = true;
            // 
            // MainWindow
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1024, 576);
            this.Controls.Add(this.tableLayoutPanel);
            this.Controls.Add(this.mainMenu);
            this.MainMenuStrip = this.mainMenu;
            this.Name = "MainWindow";
            this.Text = "ScheduleWriter";
            ((System.ComponentModel.ISupportInitialize)(this.mainGrid)).EndInit();
            this.gridPanel.ResumeLayout(false);
            this.actionCellPanel.ResumeLayout(false);
            this.mainMenu.ResumeLayout(false);
            this.mainMenu.PerformLayout();
            this.tableLayoutPanel.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel;
        private System.Windows.Forms.Panel gridPanel;
        private System.Windows.Forms.DataGridView mainGrid;
        private System.Windows.Forms.Panel actionCellPanel;
        private System.Windows.Forms.Button actionCellAddEdit;
        private System.Windows.Forms.Button actionCellCopy;
        private System.Windows.Forms.Button actionCellPaste;
        private System.Windows.Forms.Button actionCellDelete;
        private System.Windows.Forms.MenuStrip mainMenu;
        private System.Windows.Forms.ToolStripMenuItem menuToolStripMenuItem;
        private System.Windows.Forms.Button groupList;
    }
}