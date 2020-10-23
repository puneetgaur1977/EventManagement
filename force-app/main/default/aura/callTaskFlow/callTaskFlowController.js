({
    init : function (component) {
        // Find the component whose aura:id is "flowId"
        var flow = component.find("3014W000001HEYiQAO");
        // In that component, start your flow. Reference the flow's Unique Name.
        flow.startFlow("Task_Create");
    },
})
