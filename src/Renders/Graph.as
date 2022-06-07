class Graph
{
    string name = "";
    string measure = "";
    array<float> valuesHistory;
    uint historyLengthMs = 100;
    bool showValueText = true;
    int valueTextDecimals = 0;
    bool useHistogram = false;
    vec2 defaultPos = vec2(0, 0);
    vec3 color = vec3(1, 1, 1);
    float backgroundAlpha = 0.0f;

    Graph(const string &in name, const string &in measurement = "", const bool &in showValue = true, const bool &in useHistogram = false, const int &in valueTextDecimals = 0)
    {
        this.name = name;
        this.measure = measurement;
        this.showValueText = showValue;
        this.useHistogram = useHistogram;
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

        UI::PushStyleColor(UI::Col::WindowBg,vec4(.1,.1,.1,(UI::IsOverlayShown() ? 0.9 : backgroundAlpha)));
        UI::SetNextWindowSize(300,100, UI::Cond::FirstUseEver);
        UI::SetNextWindowPos(int(defaultPos.x), int(defaultPos.y), UI::Cond::FirstUseEver);
        if (UI::Begin(Icons::LineChart + " " +name+(measure.Length > 0 ? " ("+measure+")" : "")+"###Graph"+name, GetFlags())) {
            string valueText = Text::Format("%."+valueTextDecimals+"f", valuesHistory[valuesHistory.Length-1]);
            if (!UI::IsOverlayShown()) UI::Text(name+(showValueText ? (": "+valueText+" "+measure): ""));
            historyLengthMs = 100 + Text::ParseInt(Text::Format("%.0f", UI::GetWindowSize().x * 0.17));
            UI::SetNextItemWidth(UI::GetWindowSize().x - (UI::IsOverlayShown() && showValueText ? (Draw::MeasureString(valueText+" "+measure).x + 18) : 18));

            UI::PushStyleColor(UI::Col::FrameBg,vec4(.1,.1,.1,(UI::IsOverlayShown() ? 0.9 : backgroundAlpha)));
            UI::PushStyleColor(useHistogram ? UI::Col::PlotHistogram : UI::Col::PlotLines, vec4(color.x, color.y, color.z, 1));

            if (!UI::IsOverlayShown()) {
                UI::PushStyleColor(UI::Col::Text, vec4(0,0,0,0));
                UI::PushStyleColor(UI::Col::PopupBg, vec4(0,0,0,0));
            }

            if (useHistogram) UI::PlotHistogram((showValueText ? (valueText+" "+measure) : "")+"###"+name, valuesHistory, 0, UI::GetWindowSize().y - 42);
            else UI::PlotLines((showValueText ? (valueText+" "+measure) : "")+"###"+name, valuesHistory, 0, UI::GetWindowSize().y - 42);

            if (!UI::IsOverlayShown()) {
                UI::PopStyleColor(2);
            }

            UI::PopStyleColor(2);

            UI::End();
        }
        UI::PopStyleColor();
    }
}