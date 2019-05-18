using System;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;
using ScheduleWriter.Model.Beans;
using ScheduleWriter.Model.Enums;
using ScheduleWriter.View.Impls;

namespace ScheduleWriter.View.Helpers {
    public enum Condition {
        Indeterminate,  // Неопределённое
        Standart,       // Стандартное
        Expanded        // Развёрнутое
    }

    public enum State {
        Wait,           // Ожидание
        Empty,          // Скрыто/пусто
        Data            // Заполнение данными
    }

    public class StateWrapper {
        public Condition Condition { get; set; }

        public State State { get; set; }
    }

    public class EditWindowViewHelper {

        Pair _pair;

        private readonly StateWrapper[] _stateParams = new StateWrapper[9];

        public EditWindowViewHelper(Pair pair) {
            _pair = pair;
            for (var i = _stateParams.Length - 1; i >= 0; i--) {
                _stateParams[i] = new StateWrapper();
            }
        }

        public void ButtonSaveStateFix(Button b) {
            var fl = true;
            foreach (StateWrapper sw in _stateParams.Where(sw => sw.State == State.Data)) {
                fl = false;
            }
            b.Enabled = !fl;
        }

        public void SetStateData(PartPairType pairType) {

            switch (pairType) {

                case PartPairType.PairWholeGroup:
                    setMixed(_stateParams[4], _stateParams[0], _stateParams[1],
                                _stateParams[2], _stateParams[3], _stateParams[5],
                                _stateParams[6], _stateParams[7], _stateParams[8]);
                    break;

                case PartPairType.PairWholeGroupOverLine:
                    setMixed(_stateParams[1], _stateParams[0], _stateParams[2],
                                _stateParams[3], _stateParams[4], _stateParams[5]);
                    break;
                case PartPairType.PairWholeGroupBelowLine:
                    setMixed(_stateParams[7], _stateParams[3], _stateParams[4],
                                _stateParams[5], _stateParams[6], _stateParams[8]);
                    break;
                case PartPairType.PairSubgroupFirst:
                    setMixed(_stateParams[3], _stateParams[0], _stateParams[1],
                                _stateParams[2], _stateParams[4], _stateParams[6],
                                _stateParams[7], _stateParams[8]);
                    break;
                case PartPairType.PairSubgroupSecond:
                    setMixed(_stateParams[5], _stateParams[0], _stateParams[1],
                                _stateParams[2], _stateParams[4], _stateParams[6],
                                _stateParams[7], _stateParams[8]);
                    break;
                case PartPairType.PairSubgroupFirstOverLine:
                    setMixed(_stateParams[0], _stateParams[1], _stateParams[3],
                                _stateParams[4], _stateParams[5]);
                    break;
                case PartPairType.PairSubgroupSecondOverLine:
                    setMixed(_stateParams[2], _stateParams[1], _stateParams[3],
                                _stateParams[4], _stateParams[5]);
                    break;
                case PartPairType.PairSubgroupFirstBelowLine:
                    setMixed(_stateParams[6], _stateParams[7], _stateParams[5],
                                _stateParams[4], _stateParams[3]);
                    break;
                case PartPairType.PairSubgroupSecondBelowLine:
                    setMixed(_stateParams[8], _stateParams[7], _stateParams[5],
                                _stateParams[4], _stateParams[3]);
                    break;
            }
        }

        public void SetStateWait(PartPairType pairType, EditWindowView view) {
            switch (pairType) {
                case PartPairType.PairWholeGroup:
                    RemoveControlsIntoContainer(view.panel5);
                    _stateParams[4].Condition = Condition.Standart;
                    setWait(_stateParams[4], _stateParams[0], _stateParams[1],
                            _stateParams[2], _stateParams[3], _stateParams[5],
                            _stateParams[6], _stateParams[7], _stateParams[8]);
                    break;
                case PartPairType.PairWholeGroupOverLine:
                    RemoveControlsIntoContainer(view.panel2);
                    _stateParams[1].Condition = Condition.Standart;
                    setWait(_stateParams[1], _stateParams[0], _stateParams[2]);
                    if (_stateParams[7].State != State.Data &&
                        _stateParams[6].State != State.Data &&
                        _stateParams[8].State != State.Data) {
                        setWait(_stateParams[3], _stateParams[4], _stateParams[5]);
                    }
                    break;
                case PartPairType.PairWholeGroupBelowLine:
                    RemoveControlsIntoContainer(view.panel8);
                    _stateParams[7].Condition = Condition.Standart;
                    setWait(_stateParams[7], _stateParams[6], _stateParams[8]);
                    if (_stateParams[1].State != State.Data &&
                        _stateParams[0].State != State.Data &&
                        _stateParams[2].State != State.Data) {
                        setWait(_stateParams[3], _stateParams[4], _stateParams[5]);
                    }
                    break;
                case PartPairType.PairSubgroupFirst:
                    RemoveControlsIntoContainer(view.panel4);
                    _stateParams[3].Condition = Condition.Standart;
                    setWait(_stateParams[3]);
                    if (_stateParams[5].State != State.Data) {
                        setWait(_stateParams[0], _stateParams[1], _stateParams[2],
                                _stateParams[4], _stateParams[6], _stateParams[7],
                                _stateParams[8]);
                    }
                    break;
                case PartPairType.PairSubgroupSecond:
                    RemoveControlsIntoContainer(view.panel6);
                    _stateParams[5].Condition = Condition.Standart;
                    setWait(_stateParams[5]);
                    if (_stateParams[3].State != State.Data) {
                        setWait(_stateParams[0], _stateParams[1], _stateParams[2],
                                _stateParams[4], _stateParams[6], _stateParams[7],
                                _stateParams[8]);
                    }
                    break;
                case PartPairType.PairSubgroupFirstOverLine:
                    RemoveControlsIntoContainer(view.panel1);
                    _stateParams[0].Condition = Condition.Standart;
                    setWait(_stateParams[0]);
                    if (_stateParams[2].State != State.Data &&
                        _stateParams[6].State != State.Data &&
                        _stateParams[7].State != State.Data &&
                        _stateParams[8].State != State.Data) {
                        setWait(_stateParams[3], _stateParams[4], _stateParams[5]);
                    }
                    if (_stateParams[2].State != State.Data) {
                        setWait(_stateParams[1]);
                    }
                    break;
                case PartPairType.PairSubgroupSecondOverLine:
                    RemoveControlsIntoContainer(view.panel3);
                    _stateParams[2].Condition = Condition.Standart;
                    setWait(_stateParams[2]);
                    if (_stateParams[0].State != State.Data &&
                        _stateParams[6].State != State.Data &&
                        _stateParams[7].State != State.Data &&
                        _stateParams[8].State != State.Data) {
                        setWait(_stateParams[3], _stateParams[4], _stateParams[5]);
                    }
                    if (_stateParams[0].State != State.Data) {
                        setWait(_stateParams[1]);
                    }
                    break;
                case PartPairType.PairSubgroupFirstBelowLine:
                    RemoveControlsIntoContainer(view.panel7);
                    _stateParams[6].Condition = Condition.Standart;
                    setWait(_stateParams[6]);
                    if (_stateParams[8].State != State.Data &&
                        _stateParams[0].State != State.Data &&
                        _stateParams[1].State != State.Data &&
                        _stateParams[2].State != State.Data) {
                        setWait(_stateParams[3], _stateParams[4], _stateParams[5]);
                    }
                    if (_stateParams[8].State != State.Data) {
                        setWait(_stateParams[7]);
                    }
                    break;
                case PartPairType.PairSubgroupSecondBelowLine:
                    RemoveControlsIntoContainer(view.panel9);
                    _stateParams[8].Condition = Condition.Standart;
                    setWait(_stateParams[8]);
                    if (_stateParams[6].State != State.Data &&
                        _stateParams[0].State != State.Data &&
                        _stateParams[1].State != State.Data &&
                        _stateParams[2].State != State.Data) {
                        setWait(_stateParams[3], _stateParams[4], _stateParams[5]);
                    }
                    if (_stateParams[6].State != State.Data) {
                        setWait(_stateParams[7]);
                    }
                    break;
            }
            ButtonSaveStateFix(view.button11);
        }

        private void setMixed(StateWrapper dataWrapper, params StateWrapper[] emptyStates) {
            dataWrapper.Condition = Condition.Expanded;
            dataWrapper.State = State.Data;
            for (var i = emptyStates.Length - 1; i >= 0; i--) {
                emptyStates[i].State = State.Empty;
            }
        }

        private void setWait(params StateWrapper[] waitStates) {
            for (var i = waitStates.Length - 1; i >= 0; i--) {
                waitStates[i].State = State.Wait;
            }
        }

        internal void SetPanelVisible(EditWindowView view) {
            view.panel1.Visible = (_stateParams[0].State != State.Empty);
            view.panel2.Visible = (_stateParams[1].State != State.Empty);
            view.panel3.Visible = (_stateParams[2].State != State.Empty);
            view.panel4.Visible = (_stateParams[3].State != State.Empty);
            view.panel5.Visible = (_stateParams[4].State != State.Empty);
            view.panel6.Visible = (_stateParams[5].State != State.Empty);
            view.panel7.Visible = (_stateParams[6].State != State.Empty);
            view.panel8.Visible = (_stateParams[7].State != State.Empty);
            view.panel9.Visible = (_stateParams[8].State != State.Empty);
        }

        public void SetPanelBorderStyle(EditWindowView view) {
            const BorderStyle present = BorderStyle.FixedSingle;
            const BorderStyle absent = BorderStyle.None;
            view.panel1.BorderStyle = (_stateParams[0].State == State.Data) ? present : absent;
            view.panel2.BorderStyle = (_stateParams[1].State == State.Data) ? present : absent;
            view.panel3.BorderStyle = (_stateParams[2].State == State.Data) ? present : absent;
            view.panel4.BorderStyle = (_stateParams[3].State == State.Data) ? present : absent;
            view.panel5.BorderStyle = (_stateParams[4].State == State.Data) ? present : absent;
            view.panel6.BorderStyle = (_stateParams[5].State == State.Data) ? present : absent;
            view.panel7.BorderStyle = (_stateParams[6].State == State.Data) ? present : absent;
            view.panel8.BorderStyle = (_stateParams[7].State == State.Data) ? present : absent;
            view.panel9.BorderStyle = (_stateParams[8].State == State.Data) ? present : absent;
        }

        public void SetButtonVisible(EditWindowView view) {

            view.button1.Visible = (_stateParams[0].State == State.Wait);
            view.button2.Visible = (_stateParams[1].State == State.Wait);
            view.button3.Visible = (_stateParams[2].State == State.Wait);
            view.button4.Visible = (_stateParams[3].State == State.Wait);
            view.button5.Visible = (_stateParams[4].State == State.Wait);
            view.button6.Visible = (_stateParams[5].State == State.Wait);
            view.button7.Visible = (_stateParams[6].State == State.Wait);
            view.button8.Visible = (_stateParams[7].State == State.Wait);
            view.button9.Visible = (_stateParams[8].State == State.Wait);
        }

        public void SetPanelSizePosition(EditWindowView view) {

            if (_stateParams[0].State == State.Data && _stateParams[0].Condition == Condition.Expanded) {
                view.panel1.Width = (int)(view.panel1.Width * 1.5);
                view.panel1.Height = (int)(view.panel1.Height * 1.5);
                _stateParams[0].Condition = Condition.Indeterminate;
            } else if (_stateParams[0].State == State.Wait && _stateParams[0].Condition == Condition.Standart) {
                view.panel1.Width = (int)(view.panel1.Width / 1.5);
                view.panel1.Height = (int)(view.panel1.Height / 1.5);
                _stateParams[0].Condition = Condition.Indeterminate;
            }

            if (_stateParams[1].State == State.Data && _stateParams[1].Condition == Condition.Expanded) {
                view.panel2.Location = new Point(view.panel2.Location.X - view.panel2.Width, view.panel2.Location.Y);
                view.panel2.Width = view.panel2.Width * 3;
                view.panel2.Height = (int)(view.panel2.Height * 1.5);
                _stateParams[1].Condition = Condition.Indeterminate;
            } else if (_stateParams[1].State == State.Wait && _stateParams[1].Condition == Condition.Standart) {
                view.panel2.Width = (view.panel2.Width / 3);
                view.panel2.Height = (int)(view.panel2.Height / 1.5);
                view.panel2.Location = new Point(view.panel2.Location.X + view.panel2.Width, view.panel2.Location.Y);
                _stateParams[1].Condition = Condition.Indeterminate;
            }

            if (_stateParams[2].State == State.Data && _stateParams[2].Condition == Condition.Expanded) {
                view.panel3.Location = new Point(view.panel3.Location.X - view.panel3.Width / 2, view.panel3.Location.Y);
                view.panel3.Width = (int)(view.panel3.Width * 1.5);
                view.panel3.Height = (int)(view.panel3.Height * 1.5);
                _stateParams[2].Condition = Condition.Indeterminate;
            } else if (_stateParams[2].State == State.Wait && _stateParams[2].Condition == Condition.Standart) {
                view.panel3.Width = (int)(view.panel3.Width / 1.5);
                view.panel3.Height = (int)(view.panel3.Height / 1.5);
                view.panel3.Location = new Point(view.panel3.Location.X + view.panel3.Width / 2, view.panel3.Location.Y);
                _stateParams[2].Condition = Condition.Indeterminate;
            }

            if (_stateParams[3].State == State.Data && _stateParams[3].Condition == Condition.Expanded) {
                view.panel4.Location = new Point(view.panel4.Location.X, view.panel4.Location.Y - view.panel4.Height);
                view.panel4.Width = (int)(view.panel4.Width * 1.5);
                view.panel4.Height = view.panel4.Height * 3;
                _stateParams[3].Condition = Condition.Indeterminate;
            } else if (_stateParams[3].State == State.Wait && _stateParams[3].Condition == Condition.Standart) {
                view.panel4.Width = (int)(view.panel4.Width / 1.5);
                view.panel4.Height = (view.panel4.Height / 3);
                view.panel4.Location = new Point(view.panel4.Location.X, view.panel4.Location.Y + view.panel4.Height);
                _stateParams[3].Condition = Condition.Indeterminate;
            }

            if (_stateParams[4].State == State.Data && _stateParams[4].Condition == Condition.Expanded) {
                view.panel5.Location = new Point(view.panel5.Location.X - view.panel5.Width, view.panel5.Location.Y - view.panel5.Height);
                view.panel5.Width = view.panel5.Width * 3;
                view.panel5.Height = view.panel5.Height * 3;
                _stateParams[4].Condition = Condition.Indeterminate;
            } else if (_stateParams[4].State == State.Wait && _stateParams[4].Condition == Condition.Standart) {
                view.panel5.Width = (view.panel5.Width / 3);
                view.panel5.Height = (view.panel5.Height / 3);
                view.panel5.Location = new Point(view.panel5.Location.X + view.panel5.Width, view.panel5.Location.Y + view.panel5.Height);
                _stateParams[4].Condition = Condition.Indeterminate;
            }

            if (_stateParams[5].State == State.Data && _stateParams[5].Condition == Condition.Expanded) {
                view.panel6.Location = new Point(view.panel6.Location.X - view.panel6.Width / 2, view.panel6.Location.Y - view.panel6.Height);
                view.panel6.Width = (int)(view.panel6.Width * 1.5);
                view.panel6.Height = view.panel6.Height * 3;
                _stateParams[5].Condition = Condition.Indeterminate;
            } else if (_stateParams[5].State == State.Wait && _stateParams[5].Condition == Condition.Standart) {
                view.panel6.Width = (int)(view.panel6.Width / 1.5);
                view.panel6.Height = (view.panel6.Height / 3);
                view.panel6.Location = new Point(view.panel6.Location.X + view.panel6.Width / 2, view.panel6.Location.Y + view.panel6.Height);
                _stateParams[5].Condition = Condition.Indeterminate;
            }

            if (_stateParams[6].State == State.Data && _stateParams[6].Condition == Condition.Expanded) {
                view.panel7.Location = new Point(view.panel7.Location.X, view.panel7.Location.Y - view.panel7.Height / 2);
                view.panel7.Width = (int)(view.panel7.Width * 1.5);
                view.panel7.Height = (int)(view.panel7.Height * 1.5);
                _stateParams[6].Condition = Condition.Indeterminate;
            } else if (_stateParams[6].State == State.Wait && _stateParams[6].Condition == Condition.Standart) {
                view.panel7.Width = (int)(view.panel7.Width / 1.5);
                view.panel7.Height = (int)(view.panel7.Height / 1.5);
                view.panel7.Location = new Point(view.panel7.Location.X, view.panel7.Location.Y + view.panel7.Height / 2);
                _stateParams[6].Condition = Condition.Indeterminate;
            }

            if (_stateParams[7].State == State.Data && _stateParams[7].Condition == Condition.Expanded) {
                view.panel8.Location = new Point(view.panel8.Location.X - view.panel8.Width, view.panel8.Location.Y - view.panel8.Height / 2);
                view.panel8.Width = view.panel8.Width * 3;
                view.panel8.Height = (int)(view.panel8.Height * 1.5);
                _stateParams[7].Condition = Condition.Indeterminate;
            } else if (_stateParams[7].State == State.Wait && _stateParams[7].Condition == Condition.Standart) {
                view.panel8.Width = (view.panel8.Width / 3);
                view.panel8.Height = (int)(view.panel8.Height / 1.5);
                view.panel8.Location = new Point(view.panel8.Location.X + view.panel8.Width, view.panel8.Location.Y + view.panel8.Height / 2);
                _stateParams[7].Condition = Condition.Indeterminate;
            }

            if (_stateParams[8].State == State.Data && _stateParams[8].Condition == Condition.Expanded) {
                view.panel9.Location = new Point(view.panel9.Location.X - view.panel9.Width / 2, view.panel9.Location.Y - view.panel9.Height / 2);
                view.panel9.Width = (int)(view.panel9.Width * 1.5);
                view.panel9.Height = (int)(view.panel9.Height * 1.5);
                _stateParams[8].Condition = Condition.Indeterminate;
            } else if (_stateParams[8].State == State.Wait && _stateParams[8].Condition == Condition.Standart) {
                view.panel9.Width = (int)(view.panel9.Width / 1.5);
                view.panel9.Height = (int)(view.panel9.Height / 1.5);
                view.panel9.Location = new Point(view.panel9.Location.X + view.panel9.Width / 2, view.panel9.Location.Y + view.panel9.Height / 2);
                _stateParams[8].Condition = Condition.Indeterminate;
            }
        }

        public void SetVisualState(EditWindowView view) {
            SetPanelVisible(view);
            SetPanelBorderStyle(view);
            SetButtonVisible(view);
            SetPanelSizePosition(view);
            ButtonSaveStateFix(view.button11);
        }

        private void RemoveControlsIntoContainer(Control control) {
            RemoveControl("close", control);
            RemoveControl("subject", control);
            RemoveControl("audience", control);
            RemoveControl("speaker1", control);
            RemoveControl("speaker2", control);
            RemoveControl("subjectLabel", control);
            RemoveControl("audienceLabel", control);
            RemoveControl("speaker1Label", control);
            RemoveControl("speaker2Label", control);
        }

        private void RemoveControl(string controlName, Control control) {
            foreach (var item in control.Controls.OfType<Control>()) {
                if (item.Name == controlName) {
                    control.Controls.Remove(item);
                    break;
                }
            }
        }

        public void AddControlsIntoContainer(EventHandler<EventArgs> buttonCloseClick,
            Control container) {

            var close = new Button {
                Size = new Size(container.Width - 30, 35),
                Name = "close",
                Text = @"Отменить"
            };
            close.Location = new Point(15, container.Height - close.Height - 15);
            close.Click += new EventHandler(buttonCloseClick);

            var subject = new TextBox {
                Size = new Size(container.Width - 30, 40),
                Name = "subject",
                Location = new Point(15, 20)
            };

            var audience = new TextBox {
                Size = new Size(container.Width - 30, 40),
                Name = "audience",
                Location = new Point(15, 60)
            };

            var speaker1 = new TextBox {
                Size = new Size(container.Width - 30, 40),
                Name = "speaker1",
                Location = new Point(15, 100)
            };

            var speaker2 = new TextBox {
                Size = new Size(container.Width - 30, 40),
                Name = "speaker2",
                Location = new Point(15, 140)
            };

            var subjectLabel = new Label {
                Text = @"Предмет:",
                Name = "subjectLabel",
                Location = new Point(15, 5)
            };

            var audienceLabel = new Label {
                Text = @"Аудитория:",
                Name = "audienceLabel",
                Location = new Point(15, 45)
            };

            var speaker1Label = new Label {
                Text = @"Лектор 1:",
                Name = "speaker1Label",
                Location = new Point(15, 85)
            };

            var speaker2Label = new Label {
                Text = @"Лектор 2:",
                Name = "speaker2Label",
                Location = new Point(15, 125)
            };

            container.Controls.Add(subject);
            container.Controls.Add(audience);
            container.Controls.Add(speaker1);
            container.Controls.Add(speaker2);
            container.Controls.Add(close);
            container.Controls.Add(subjectLabel);
            container.Controls.Add(audienceLabel);
            container.Controls.Add(speaker1Label);
            container.Controls.Add(speaker2Label);
        }

        public bool SavePair(EditWindowView view) {
            var result = true;
            if (_stateParams[0].State == State.Data) {
                result = Add(view.panel1, PartPairType.PairSubgroupFirstOverLine);
            }
            if ((_stateParams[1].State == State.Data) && (result)) {
                result = Add(view.panel2, PartPairType.PairWholeGroupOverLine);
            }
            if ((_stateParams[2].State == State.Data) && (result)) {
                result = Add(view.panel3, PartPairType.PairSubgroupSecondOverLine);
            }
            if ((_stateParams[3].State == State.Data) && (result)) {
                result = Add(view.panel4, PartPairType.PairSubgroupFirst);
            }
            if ((_stateParams[4].State == State.Data) && (result)) {
                result = Add(view.panel5, PartPairType.PairWholeGroup);
            }
            if ((_stateParams[5].State == State.Data) && (result)) {
                result = Add(view.panel6, PartPairType.PairSubgroupSecond);
            }
            if ((_stateParams[6].State == State.Data) && (result)) {
                result = Add(view.panel7, PartPairType.PairSubgroupFirstBelowLine);
            }
            if ((_stateParams[7].State == State.Data) && (result)) {
                result = Add(view.panel8, PartPairType.PairWholeGroupBelowLine);
            }
            if ((_stateParams[8].State == State.Data) && (result)) {
                result = Add(view.panel9, PartPairType.PairSubgroupSecondBelowLine);
            }
            if (result) {
                if (_stateParams[0].State != State.Data) {
                    ClearPart(PartPairType.PairSubgroupFirstOverLine);
                }
                if (_stateParams[1].State != State.Data) {
                    ClearPart(PartPairType.PairWholeGroupOverLine);
                }
                if (_stateParams[2].State != State.Data) {
                    ClearPart(PartPairType.PairSubgroupSecondOverLine);
                }
                if (_stateParams[3].State != State.Data) {
                    ClearPart(PartPairType.PairSubgroupFirst);
                }
                if (_stateParams[4].State != State.Data) {
                    ClearPart(PartPairType.PairWholeGroup);
                }
                if (_stateParams[5].State != State.Data) {
                    ClearPart(PartPairType.PairSubgroupSecond);
                }
                if (_stateParams[6].State != State.Data) {
                    ClearPart(PartPairType.PairSubgroupFirstBelowLine);
                }
                if (_stateParams[7].State != State.Data) {
                    ClearPart(PartPairType.PairWholeGroupBelowLine);
                }
                if (_stateParams[8].State != State.Data) {
                    ClearPart(PartPairType.PairSubgroupSecondBelowLine);
                }
            }
            return result;
        }

        private TextBox GetDynamicTextbox(string controlName, Control control) {
            return control.Controls.Find(controlName, true).FirstOrDefault() as TextBox;
        }

        private bool Add(Panel panel, PartPairType type) {
            string subject = GetDynamicTextbox("subject", panel).Text.Trim();
            if (subject == "") {
                MessageBox.Show(@"Не заполнено поле ""Предмет""");
                return false;
            }
            string audience = GetDynamicTextbox("audience", panel).Text.Trim();
            string speaker1 = GetDynamicTextbox("speaker1", panel).Text.Trim();
            string speaker2 = GetDynamicTextbox("speaker2", panel).Text.Trim();
            PartPair partPair = new PartPair(subject, audience, speaker1, speaker2, type);
            ClearPart(type);
            _pair.PartPairs.Add(partPair);
            return true;
        }

        private void ClearPart(PartPairType type) {
            for (int i = _pair.PartPairs.Count - 1; i >= 0; i--) {
                if (_pair.PartPairs[i].Type == type) {
                    _pair.PartPairs.RemoveAt(i);
                    break;
                }
            }
        }
    }
}