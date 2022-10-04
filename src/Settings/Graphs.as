namespace SettingsGraphs
{
    [Setting hidden]
    bool showRenderGraphs = true;

    array<string> graphTypes = {"Line","Histogram"};

    array<string> RateUnit = {"Bytes", "KB", "MB"};

    [Setting hidden]
    bool showFpsGraph = true;

    [Setting hidden]
    bool displayFpsValueGraph = true;

    [Setting hidden]
    int fpsDecimalsGraph = 0;

    [Setting hidden]
    bool displayFpsHistogramGraph = false;

    [Setting hidden]
    vec3 displayFpsColorGraph = vec3(1,1,1);

    [Setting hidden]
    float displayFpsAlphaGraph = 0.0f;

    [Setting hidden]
    bool showPingGraph = true;

    [Setting hidden]
    bool displayPingValueGraph = true;

    [Setting hidden]
    bool displayPingHistogramGraph = false;

    [Setting hidden]
    vec3 displayPingColorGraph = vec3(1,1,1);

    [Setting hidden]
    float displayPingAlphaGraph = 0.0f;

    [Setting hidden]
    bool showPacketLossGraph = true;

    [Setting hidden]
    bool displayPacketLossValueGraph = true;

    [Setting hidden]
    bool displayPacketLossHistogramGraph = false;

    [Setting hidden]
    vec3 displayPacketLossColorGraph = vec3(1,1,1);

    [Setting hidden]
    float displayPacketLossAlphaGraph = 0.0f;

    [Setting hidden]
    bool showDownloadRateGraph = false;

    [Setting hidden]
    bool displayDLValueGraph = true;

    [Setting hidden]
    bool displayDLHistogramGraph = false;

    [Setting hidden]
    string displayDLRateUnitGraph = RateUnit[0];

    [Setting hidden]
    vec3 displayDLColorGraph = vec3(1,1,1);

    [Setting hidden]
    float displayDLAlphaGraph = 0.0f;

    [Setting hidden]
    bool showUploadRateGraph = false;

    [Setting hidden]
    bool displayULValueGraph = true;

    [Setting hidden]
    bool displayULHistogramGraph = false;

    [Setting hidden]
    string displayULRateUnitGraph = RateUnit[0];

    [Setting hidden]
    vec3 displayULColorGraph = vec3(1,1,1);

    [Setting hidden]
    float displayULAlphaGraph = 0.0f;


    [SettingsTab name="Graphs"]
    void RenderGraphsSettings() {
        showRenderGraphs = UI::Checkbox("Show All Graphs", showRenderGraphs);
        UI::Text("To move/resize graphs, the Openplanet overlay must be shown");
        UI::TextDisabled(Icons::InfoCircle + " Alpha setting are not affected when the overlay is shown");
        UI::Separator();

        UI::BeginTabBar("GraphsSettingsTabBar", UI::TabBarFlags::FittingPolicyResizeDown);
        if (UI::BeginTabItem("Framerate")) {
            RenderFramerateGraphSettings();
            UI::EndTabItem();
        }
        if (UI::BeginTabItem("Ping")) {
            RenderPingGraphSettings();
            UI::EndTabItem();
        }
        if (UI::BeginTabItem("Packet Loss Rate")) {
            RenderPacketLossGraphSettings();
            UI::EndTabItem();
        }
        if (UI::BeginTabItem("Download Rate")) {
            RenderDLGraphSettings();
            UI::EndTabItem();
        }
        if (UI::BeginTabItem("Upload Rate")) {
            RenderULGraphSettings();
            UI::EndTabItem();
        }
        UI::EndTabBar();
    }


    void RenderFramerateGraphSettings() {
        showFpsGraph = UI::Checkbox("Show Framerate graph", showFpsGraph);
        displayFpsValueGraph = UI::Checkbox("Display value text", displayFpsValueGraph);
        if (displayFpsValueGraph) fpsDecimalsGraph = UI::SliderInt("Value decimals", fpsDecimalsGraph, 0, 3);

        string framerateTypeSetting = displayFpsHistogramGraph ? graphTypes[1] : graphTypes[0];
        if (UI::BeginCombo("Graph type", framerateTypeSetting)){
            for (uint i = 0; i < graphTypes.Length; i++) {
                string type = graphTypes[i];

                if (UI::Selectable(type, framerateTypeSetting == type)) {
                    framerateTypeSetting = type;
                    displayFpsHistogramGraph = framerateTypeSetting == graphTypes[1];
                }

                if (framerateTypeSetting == type) {
                    UI::SetItemDefaultFocus();
                }
            }
            UI::EndCombo();
        }

        displayFpsColorGraph = UI::InputColor3("Color", displayFpsColorGraph);
        displayFpsAlphaGraph = UI::SliderFloat("Graph alpha", displayFpsAlphaGraph, 0.0f, 1.0f);
    }

    void RenderPingGraphSettings() {
        showPingGraph = UI::Checkbox("Show Ping graph", showPingGraph);
        displayPingValueGraph = UI::Checkbox("Display value text", displayPingValueGraph);

        string pingTypeSetting = displayPingHistogramGraph ? graphTypes[1] : graphTypes[0];
        if (UI::BeginCombo("Graph type", pingTypeSetting)){
            for (uint i = 0; i < graphTypes.Length; i++) {
                string type = graphTypes[i];

                if (UI::Selectable(type, pingTypeSetting == type)) {
                    pingTypeSetting = type;
                    displayPingHistogramGraph = pingTypeSetting == graphTypes[1];
                }

                if (pingTypeSetting == type) {
                    UI::SetItemDefaultFocus();
                }
            }
            UI::EndCombo();
        }

        displayPingColorGraph = UI::InputColor3("Color", displayPingColorGraph);
        displayPingAlphaGraph = UI::SliderFloat("Graph alpha", displayPingAlphaGraph, 0.0f, 1.0f);
    }

    void RenderPacketLossGraphSettings() {
        showPacketLossGraph = UI::Checkbox("Show PacketLoss graph", showPacketLossGraph);
        displayPacketLossValueGraph = UI::Checkbox("Display value text", displayPacketLossValueGraph);

        string packetLossTypeSetting = displayPacketLossHistogramGraph ? graphTypes[1] : graphTypes[0];
        if (UI::BeginCombo("Graph type", packetLossTypeSetting)){
            for (uint i = 0; i < graphTypes.Length; i++) {
                string type = graphTypes[i];

                if (UI::Selectable(type, packetLossTypeSetting == type)) {
                    packetLossTypeSetting = type;
                    displayPacketLossHistogramGraph = packetLossTypeSetting == graphTypes[1];
                }

                if (packetLossTypeSetting == type) {
                    UI::SetItemDefaultFocus();
                }
            }
            UI::EndCombo();
        }

        displayPacketLossColorGraph = UI::InputColor3("Color", displayPacketLossColorGraph);
        displayPacketLossAlphaGraph = UI::SliderFloat("Graph alpha", displayPacketLossAlphaGraph, 0.0f, 1.0f);
    }

    void RenderDLGraphSettings() {
        showDownloadRateGraph = UI::Checkbox("Show Download Rate graph", showDownloadRateGraph);
        displayDLValueGraph = UI::Checkbox("Display value text", displayDLValueGraph);

        if (UI::BeginCombo("Rate unit", displayDLRateUnitGraph)){
            for (uint i = 0; i < RateUnit.Length; i++) {
                string type = RateUnit[i];

                if (UI::Selectable(type, displayDLRateUnitGraph == type)) {
                    displayDLRateUnitGraph = type;
                }

                if (displayDLRateUnitGraph == type) {
                    UI::SetItemDefaultFocus();
                }
            }
            UI::EndCombo();
        }

        string framerateTypeSetting = displayDLHistogramGraph ? graphTypes[1] : graphTypes[0];
        if (UI::BeginCombo("Graph type", framerateTypeSetting)){
            for (uint i = 0; i < graphTypes.Length; i++) {
                string type = graphTypes[i];

                if (UI::Selectable(type, framerateTypeSetting == type)) {
                    framerateTypeSetting = type;
                    displayDLHistogramGraph = framerateTypeSetting == graphTypes[1];
                }

                if (framerateTypeSetting == type) {
                    UI::SetItemDefaultFocus();
                }
            }
            UI::EndCombo();
        }

        displayDLColorGraph = UI::InputColor3("Color", displayDLColorGraph);
        displayDLAlphaGraph = UI::SliderFloat("Graph alpha", displayDLAlphaGraph, 0.0f, 1.0f);
    }

    void RenderULGraphSettings() {
        showUploadRateGraph = UI::Checkbox("Show Upload Rate graph", showUploadRateGraph);
        displayULValueGraph = UI::Checkbox("Display value text", displayULValueGraph);

        if (UI::BeginCombo("Rate unit", displayULRateUnitGraph)){
            for (uint i = 0; i < RateUnit.Length; i++) {
                string type = RateUnit[i];

                if (UI::Selectable(type, displayULRateUnitGraph == type)) {
                    displayULRateUnitGraph = type;
                }

                if (displayULRateUnitGraph == type) {
                    UI::SetItemDefaultFocus();
                }
            }
            UI::EndCombo();
        }

        string framerateTypeSetting = displayULHistogramGraph ? graphTypes[1] : graphTypes[0];
        if (UI::BeginCombo("Graph type", framerateTypeSetting)){
            for (uint i = 0; i < graphTypes.Length; i++) {
                string type = graphTypes[i];

                if (UI::Selectable(type, framerateTypeSetting == type)) {
                    framerateTypeSetting = type;
                    displayULHistogramGraph = framerateTypeSetting == graphTypes[1];
                }

                if (framerateTypeSetting == type) {
                    UI::SetItemDefaultFocus();
                }
            }
            UI::EndCombo();
        }

        displayULColorGraph = UI::InputColor3("Color", displayULColorGraph);
        displayULAlphaGraph = UI::SliderFloat("Graph alpha", displayULAlphaGraph, 0.0f, 1.0f);
    }
}