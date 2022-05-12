class Graph
{
    string name = "";
    array<float> valuesHistory;
    uint historyLengthMs = 100;
    bool showValueText = true;
    int valueTextDecimals = 0;
    bool useHostogram = false;

    Graph(const string &in name, bool showValue = true, bool useHostogram = false, int valueTextDecimals = 0)
    {
        this.name = name;
        this.showValueText = showValue;
        this.useHostogram = useHostogram;
        this.valueTextDecimals = valueTextDecimals;
    }

    int GetFlags()
    {
        int flags = UI::WindowFlags::NoCollapse | UI::WindowFlags::NoDocking;
        if (!UI::IsOverlayShown()) flags |= UI::WindowFlags::NoTitleBar | UI::WindowFlags::NoMove | UI::WindowFlags::NoResize;
        return flags;
    }

    void Render(float value)
    {
        valuesHistory.InsertLast(value);
        if (valuesHistory.Length > historyLengthMs)
        {
            valuesHistory.RemoveRange(0, valuesHistory.Length - historyLengthMs);
        }

        UI::PushStyleColor(UI::Col::WindowBg,vec4(.1,.1,.1,(UI::IsOverlayShown() ? 0.9 : 0)));
        if (UI::Begin(Icons::LineChart + " " +name+"###Graph", GetFlags())) {
            if (!UI::IsOverlayShown()) UI::Text(name);
            historyLengthMs = 100 + Text::ParseInt(Text::Format("%.0f", UI::GetWindowSize().x * 0.17));
            string valueText = Text::Format("%."+valueTextDecimals+"f", valuesHistory[valuesHistory.Length-1]);
            UI::SetNextItemWidth(UI::GetWindowSize().x - (showValueText ? (Draw::MeasureString(valueText).x + 18) : 18));

            UI::PushStyleColor(UI::Col::FrameBg,vec4(.1,.1,.1,(UI::IsOverlayShown() ? 0.9 : 0)));
            if (useHostogram) UI::PlotHistogram((showValueText ? valueText : "")+"###"+name, valuesHistory, 0, UI::GetWindowSize().y - 42);
            else UI::PlotLines((showValueText ? valueText : "")+"###"+name, valuesHistory, 0, UI::GetWindowSize().y - 42);
            UI::PopStyleColor();

            UI::End();
        }
        UI::PopStyleColor();
    }
}