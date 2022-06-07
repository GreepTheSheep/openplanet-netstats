namespace SettingsGraphs
{
    [Setting hidden]
    bool showRender = true;

    array<string> graphTypes = {"Line","Histogram"};

    array<string> RateUnit = {"Bytes", "KB", "MB"};

    [Setting hidden]
    bool showFps = true;

    [Setting hidden]
    bool displayFpsValue = true;

    [Setting hidden]
    int fpsDecimals = 0;

    [Setting hidden]
    bool displayFpsHistogram = false;

    [Setting hidden]
    vec3 displayFpsColor = vec3(1,1,1);

    [Setting hidden]
    float displayFpsAlpha = 0.0f;

    [Setting hidden]
    bool showPing = true;

    [Setting hidden]
    bool displayPingValue = true;

    [Setting hidden]
    bool displayPingHistogram = false;

    [Setting hidden]
    vec3 displayPingColor = vec3(1,1,1);

    [Setting hidden]
    float displayPingAlpha = 0.0f;

    [Setting hidden]
    bool showPacketLoss = true;

    [Setting hidden]
    bool displayPacketLossValue = true;

    [Setting hidden]
    bool displayPacketLossHistogram = false;

    [Setting hidden]
    vec3 displayPacketLossColor = vec3(1,1,1);

    [Setting hidden]
    float displayPacketLossAlpha = 0.0f;

    [Setting hidden]
    bool showDownloadRate = false;

    [Setting hidden]
    bool displayDLValue = true;

    [Setting hidden]
    bool displayDLHistogram = false;

    [Setting hidden]
    string displayDLRateUnit = RateUnit[0];

    [Setting hidden]
    vec3 displayDLColor = vec3(1,1,1);

    [Setting hidden]
    float displayDLAlpha = 0.0f;

    [Setting hidden]
    bool showUploadRate = false;

    [Setting hidden]
    bool displayULValue = true;

    [Setting hidden]
    bool displayULHistogram = false;

    [Setting hidden]
    string displayULRateUnit = RateUnit[0];

    [Setting hidden]
    vec3 displayULColor = vec3(1,1,1);

    [Setting hidden]
    float displayULAlpha = 0.0f;


    [SettingsTab name="Graphs"]
    void RenderGraphsSettings() {
        showRender = UI::Checkbox("Show All Graphs", showRender);
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
        showFps = UI::Checkbox("Show Framerate graph", showFps);
        displayFpsValue = UI::Checkbox("Display value text", displayFpsValue);
        if (displayFpsValue) fpsDecimals = UI::SliderInt("Value decimals", fpsDecimals, 0, 3);

        string framerateTypeSetting = displayFpsHistogram ? graphTypes[1] : graphTypes[0];
        if (UI::BeginCombo("Graph type", framerateTypeSetting)){
            for (uint i = 0; i < graphTypes.Length; i++) {
                string type = graphTypes[i];

                if (UI::Selectable(type, framerateTypeSetting == type)) {
                    framerateTypeSetting = type;
                    displayFpsHistogram = framerateTypeSetting == graphTypes[1];
                }

                if (framerateTypeSetting == type) {
                    UI::SetItemDefaultFocus();
                }
            }
            UI::EndCombo();
        }

        displayFpsColor = UI::InputColor3("Color", displayFpsColor);
        displayFpsAlpha = UI::SliderFloat("Graph alpha", displayFpsAlpha, 0.0f, 1.0f);
    }

    void RenderPingGraphSettings() {
        showPing = UI::Checkbox("Show Ping graph", showPing);
        displayPingValue = UI::Checkbox("Display value text", displayPingValue);

        string pingTypeSetting = displayPingHistogram ? graphTypes[1] : graphTypes[0];
        if (UI::BeginCombo("Graph type", pingTypeSetting)){
            for (uint i = 0; i < graphTypes.Length; i++) {
                string type = graphTypes[i];

                if (UI::Selectable(type, pingTypeSetting == type)) {
                    pingTypeSetting = type;
                    displayPingHistogram = pingTypeSetting == graphTypes[1];
                }

                if (pingTypeSetting == type) {
                    UI::SetItemDefaultFocus();
                }
            }
            UI::EndCombo();
        }

        displayPingColor = UI::InputColor3("Color", displayPingColor);
        displayPingAlpha = UI::SliderFloat("Graph alpha", displayPingAlpha, 0.0f, 1.0f);
    }

    void RenderPacketLossGraphSettings() {
        showPacketLoss = UI::Checkbox("Show PacketLoss graph", showPacketLoss);
        displayPacketLossValue = UI::Checkbox("Display value text", displayPacketLossValue);

        string packetLossTypeSetting = displayPacketLossHistogram ? graphTypes[1] : graphTypes[0];
        if (UI::BeginCombo("Graph type", packetLossTypeSetting)){
            for (uint i = 0; i < graphTypes.Length; i++) {
                string type = graphTypes[i];

                if (UI::Selectable(type, packetLossTypeSetting == type)) {
                    packetLossTypeSetting = type;
                    displayPacketLossHistogram = packetLossTypeSetting == graphTypes[1];
                }

                if (packetLossTypeSetting == type) {
                    UI::SetItemDefaultFocus();
                }
            }
            UI::EndCombo();
        }

        displayPacketLossColor = UI::InputColor3("Color", displayPacketLossColor);
        displayPacketLossAlpha = UI::SliderFloat("Graph alpha", displayPacketLossAlpha, 0.0f, 1.0f);
    }

    void RenderDLGraphSettings() {
        showDownloadRate = UI::Checkbox("Show Download Rate graph", showDownloadRate);
        displayDLValue = UI::Checkbox("Display value text", displayDLValue);

        if (UI::BeginCombo("Rate unit", displayDLRateUnit)){
            for (uint i = 0; i < RateUnit.Length; i++) {
                string type = RateUnit[i];

                if (UI::Selectable(type, displayDLRateUnit == type)) {
                    displayDLRateUnit = type;
                }

                if (displayDLRateUnit == type) {
                    UI::SetItemDefaultFocus();
                }
            }
            UI::EndCombo();
        }

        string framerateTypeSetting = displayDLHistogram ? graphTypes[1] : graphTypes[0];
        if (UI::BeginCombo("Graph type", framerateTypeSetting)){
            for (uint i = 0; i < graphTypes.Length; i++) {
                string type = graphTypes[i];

                if (UI::Selectable(type, framerateTypeSetting == type)) {
                    framerateTypeSetting = type;
                    displayDLHistogram = framerateTypeSetting == graphTypes[1];
                }

                if (framerateTypeSetting == type) {
                    UI::SetItemDefaultFocus();
                }
            }
            UI::EndCombo();
        }

        displayDLColor = UI::InputColor3("Color", displayDLColor);
        displayDLAlpha = UI::SliderFloat("Graph alpha", displayDLAlpha, 0.0f, 1.0f);
    }

    void RenderULGraphSettings() {
        showUploadRate = UI::Checkbox("Show Upload Rate graph", showUploadRate);
        displayULValue = UI::Checkbox("Display value text", displayULValue);

        if (UI::BeginCombo("Rate unit", displayULRateUnit)){
            for (uint i = 0; i < RateUnit.Length; i++) {
                string type = RateUnit[i];

                if (UI::Selectable(type, displayULRateUnit == type)) {
                    displayULRateUnit = type;
                }

                if (displayULRateUnit == type) {
                    UI::SetItemDefaultFocus();
                }
            }
            UI::EndCombo();
        }

        string framerateTypeSetting = displayULHistogram ? graphTypes[1] : graphTypes[0];
        if (UI::BeginCombo("Graph type", framerateTypeSetting)){
            for (uint i = 0; i < graphTypes.Length; i++) {
                string type = graphTypes[i];

                if (UI::Selectable(type, framerateTypeSetting == type)) {
                    framerateTypeSetting = type;
                    displayULHistogram = framerateTypeSetting == graphTypes[1];
                }

                if (framerateTypeSetting == type) {
                    UI::SetItemDefaultFocus();
                }
            }
            UI::EndCombo();
        }

        displayULColor = UI::InputColor3("Color", displayULColor);
        displayULAlpha = UI::SliderFloat("Graph alpha", displayULAlpha, 0.0f, 1.0f);
    }
}