namespace SettingsGraphs
{
    [Setting hidden]
    bool showRender = true;

    array<string> graphTypes = {"Line","Histogram"};

    [Setting hidden]
    bool showFps = true;

    [Setting hidden]
    bool displayFpsValue = true;

    [Setting hidden]
    int fpsDecimals = 0;

    [Setting hidden]
    bool displayFpsHistogram = false;


    [SettingsTab name="Graphs"]
    void RenderGraphsSettings() {
        showRender = UI::Checkbox("Show All Graphs", showRender);
        UI::Text("To move/resize graphs, the Openplanet overlay must be shown");
        UI::Separator();

        UI::BeginTabBar("GraphsSettingsTabBar", UI::TabBarFlags::FittingPolicyResizeDown);
        if (UI::BeginTabItem("Framerate")) {
            RenderFramerateGraphSettings();
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
    }
}