using System;
using System.Linq;
using System.Windows.Forms;
using ScheduleWriter.Controllers;
using ScheduleWriter.Model.Beans;
using ScheduleWriter.Model.Enums;
using ScheduleWriter.View.Helpers;

namespace ScheduleWriter.View.Impls {

    public partial class EditWindowView : Form {

        private readonly Pair _pair;

        private readonly MainController _controller;

        private readonly EditWindowViewHelper _helper;

        public EditWindowView(Pair pair, MainController controller) {
            InitializeComponent();
            _pair = pair;
            _controller = controller;
            _helper = new EditWindowViewHelper(pair);
            weekDaylabel.Text = EnumDescription.GetEnumDescription(pair.WeekDay);
            pairNumberlabel.Text = EnumDescription.GetEnumDescription(pair.NumberPair);
            WriteExitingFields();
            _helper.ButtonSaveStateFix(button11);
        }

        private void button5_Click(object sender, EventArgs e) {
            button5_Handler();
        }

        private void button4_Click(object sender, EventArgs e) {
            button4_Handler();
        }

        private void button6_Click(object sender, EventArgs e) {
            button6_Handler();
        }

        private void button1_Click(object sender, EventArgs e) {
            button1_Handler();
        }

        private void button2_Click(object sender, EventArgs e) {
            button2_Handler();
        }

        private void button3_Click(object sender, EventArgs e) {
            button3_Handler();
        }

        private void button7_Click(object sender, EventArgs e) {
            button7_Handler();
        }

        private void button8_Click(object sender, EventArgs e) {
            button8_Handler();
        }

        private void button9_Click(object sender, EventArgs e) {
            button9_Handler();
        }

        private void button5_Handler() {
            _helper.SetStateData(PartPairType.PairWholeGroup);
            _helper.SetVisualState(this);
            _helper.AddControlsIntoContainer(buttonClose5_Click, panel5);
        }

        private void button4_Handler() {
            _helper.SetStateData(PartPairType.PairSubgroupFirst);
            _helper.SetVisualState(this);
            _helper.AddControlsIntoContainer(buttonClose4_Click, panel4);
        }

        private void button6_Handler() {
            _helper.SetStateData(PartPairType.PairSubgroupSecond);
            _helper.SetVisualState(this);
            _helper.AddControlsIntoContainer(buttonClose6_Click, panel6);
        }

        private void button1_Handler() {
            _helper.SetStateData(PartPairType.PairSubgroupFirstOverLine);
            _helper.SetVisualState(this);
            _helper.AddControlsIntoContainer(buttonClose1_Click, panel1);
        }

        private void button2_Handler() {
            _helper.SetStateData(PartPairType.PairWholeGroupOverLine);
            _helper.SetVisualState(this);
            _helper.AddControlsIntoContainer(buttonClose2_Click, panel2);
        }

        private void button3_Handler() {
            _helper.SetStateData(PartPairType.PairSubgroupSecondOverLine);
            _helper.SetVisualState(this);
            _helper.AddControlsIntoContainer(buttonClose3_Click, panel3);
        }

        private void button7_Handler() {
            _helper.SetStateData(PartPairType.PairSubgroupFirstBelowLine);
            _helper.SetVisualState(this);
            _helper.AddControlsIntoContainer(buttonClose7_Click, panel7);
        }

        private void button8_Handler() {
            _helper.SetStateData(PartPairType.PairWholeGroupBelowLine);
            _helper.SetVisualState(this);
            _helper.AddControlsIntoContainer(buttonClose8_Click, panel8);
        }

        private void button9_Handler() {
            _helper.SetStateData(PartPairType.PairSubgroupSecondBelowLine);
            _helper.SetVisualState(this);
            _helper.AddControlsIntoContainer(buttonClose9_Click, panel9);
        }

        // назад
        private void button10_Click(object sender, EventArgs e) {
            Close();
        }

        // вперёд / сохранить
        private void button11_Click(object sender, EventArgs e) {
            if (_helper.SavePair(this))
            {
                _controller.AddPairAfterEditing(_pair);
                Close();
            }
        }

        // Динамические кнопка отмены
        private void buttonClose1_Click(object sender, EventArgs e) {
            _helper.SetStateWait(PartPairType.PairSubgroupFirstOverLine, this);
            _helper.SetVisualState(this);
        }

        private void buttonClose2_Click(object sender, EventArgs e) {
            _helper.SetStateWait(PartPairType.PairWholeGroupOverLine, this);
            _helper.SetVisualState(this);
        }

        private void buttonClose3_Click(object sender, EventArgs e) {
            _helper.SetStateWait(PartPairType.PairSubgroupSecondOverLine, this);
            _helper.SetVisualState(this);
        }

        private void buttonClose4_Click(object sender, EventArgs e) {
            _helper.SetStateWait(PartPairType.PairSubgroupFirst, this);
            _helper.SetVisualState(this);
        }

        private void buttonClose5_Click(object sender, EventArgs e) {
            _helper.SetStateWait(PartPairType.PairWholeGroup, this);
            _helper.SetVisualState(this);
        }

        private void buttonClose6_Click(object sender, EventArgs e) {
            _helper.SetStateWait(PartPairType.PairSubgroupSecond, this);
            _helper.SetVisualState(this);
        }

        private void buttonClose7_Click(object sender, EventArgs e) {
            _helper.SetStateWait(PartPairType.PairSubgroupFirstBelowLine, this);
            _helper.SetVisualState(this);
        }

        private void buttonClose8_Click(object sender, EventArgs e) {
            _helper.SetStateWait(PartPairType.PairWholeGroupBelowLine, this);
            _helper.SetVisualState(this);
        }

        private void buttonClose9_Click(object sender, EventArgs e) {
            _helper.SetStateWait(PartPairType.PairSubgroupSecondBelowLine, this);
            _helper.SetVisualState(this);
        }

        private void WriteExitingFields() {
            foreach (var currentPart in _pair.PartPairs) {
                switch (currentPart.Type) {
                    case PartPairType.PairWholeGroup:
                        button5_Handler();
                        WritePart(panel5, currentPart);
                        break;
                    case PartPairType.PairWholeGroupOverLine:
                        button2_Handler();
                        WritePart(panel2, currentPart);
                        break;
                    case PartPairType.PairWholeGroupBelowLine:
                        button8_Handler();
                        WritePart(panel8, currentPart);
                        break;
                    case PartPairType.PairSubgroupFirst:
                        button4_Handler();
                        WritePart(panel4, currentPart);
                        break;
                    case PartPairType.PairSubgroupSecond:
                        button6_Handler();
                        WritePart(panel6, currentPart);
                        break;
                    case PartPairType.PairSubgroupFirstOverLine:
                        button1_Handler();
                        WritePart(panel1, currentPart);
                        break;
                    case PartPairType.PairSubgroupSecondOverLine:
                        button3_Handler();
                        WritePart(panel3, currentPart);
                        break;
                    case PartPairType.PairSubgroupFirstBelowLine:
                        button7_Handler();
                        WritePart(panel7, currentPart);
                        break;
                    case PartPairType.PairSubgroupSecondBelowLine:
                        button9_Handler();
                        WritePart(panel9, currentPart);
                        break;
                }
            }
        }

        private void WritePart(Control control, PartPair part)
        {
            GetDynamicTextbox("subject", control).Text = part.SubjectName;
            GetDynamicTextbox("audience", control).Text = part.Audience;
            GetDynamicTextbox("speaker1", control).Text = part.Lecturer1;
            GetDynamicTextbox("speaker2", control).Text = part.Lecturer2;
        }

        private TextBox GetDynamicTextbox(string controlName, Control control)
        {
            return control.Controls.Find(controlName, true).FirstOrDefault() as TextBox;
        }
    }
}
