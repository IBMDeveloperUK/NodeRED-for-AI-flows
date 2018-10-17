# Azure Cognitive services with NodeRED

now that you have the IBM Watson Cogntive services working in NodeRED,
let's see what would be needed to do the same/similar with Microsot Azure Cognitive Services.

You will need to add a [Computer Vision](https://azure.microsoft.com/en-us/services/cognitive-services/directory/vision/) service subscription
to your Azure account. We will use a limited free service subscription for this.

## Azure Computer Vision subscription
Let's start with create the computer vision resource in the Azure portal

![azure portal - cv](img/mg-brs-azure-cv-select.png)

Select "Computer Vision"

![azure cv create](img/mg-brs-azure-cv-create.png)

Click `Create`

![azure cv settings](img/mg-brs-azure-cv-settings.png)

**Note** that the Location property has been overidden to **"West US"** -
this is necessary for the current version of the Azure NodeRED nodes,
which do not yet provide a means of selecting different regional endpoints.

**Note** the Pricing tier has been set to F0 - a free, but restricted plan.

Again, click `Create`

Once the subscription is active, you will be able to see it in the "All resources" view:

![azure all resources](img/mg-brs-azure-cv-active.png)

Click on the subscription name (in this case, "brs-cv-westus") to view its details:

![azure cv details](img/mg-brs-azure-cv-details.png)

At this point, we are particularly interested in the  `Grab your keys` section -
the API will be added into the configuration of the NodeRED Azure node.
Click on`Keys`

![azure vc keys](img/mg-brs-azure-cv-keys.png)

Here, you wil see 2 keys - either one can be used -- copy one to your favourite scratchpad for later use.

Use a similar process to set up subscriptions for other Cognitive Services.

## NodeRED setup for Azure Cognitive Services

With a minor modification to the existing image classification flow,
you can enhance the image interpretation -
![azure cv flow](img/mg-brs-azure-cv-flow.png)

For this to work, you will need to install the `node-red-contrib-cognitive-services` package.
Use the "Manage Palette" method to does this.
![azure install in nodered](img/mg-brs-azure-install.png)

You should now have, in the left-hand palette, a new set of nodes

![azure nodes](img/mg-brs-azure-nodes.png)

Pull the `Computer Vision` node onto the canvas and link it into the existing flow, between the Watson Visual Recognition node, and the output template node.

![azure cv insert](img/mg-brs-azure-cv-insert.png)

and configure with the subscription API key

![azure cv config](img/mg-brs-azure-cv-config.png).

Almost ready to update the runtime, but the content/format of the output from the Azure service is not known; add a `debug` node after the `computer vison` node,
to allow inspection of the data returned from the API call.

![azure cv debug](img/mg-brs-azure-cv-debug.png)

Click the `Deploy` button

![deploy](img/qcon-deploy-button.png)

Now, redo the image classification, and observe the output in the NodeRED debug window.
The key piece of content that Azure provides is a descriptionn of the image, which you can find in the `msg.detail.description.captions` array

![azure cv response](img/mg-brs-azure-cv-response.png)

All that is needed now is to incorporate that information into the response template

![azure cv template](img/mg-brs-azure-cv-template.png)

The new template will be
```
{#detail}}
 {{#description}}
  {{#captions}}
   <strong>{{text}} ({{confidence}})</strong>
  {{/captions}}
 {{/description}}
{{/detail}}

{{#result}}
<table>
 {{#images}}
  {{#classifiers}}
    {{#classes}}
        <tr><td>{{class}}</td><td>{{score}}</td><td>{{{type_hierarchy}}}</td></tr>
    {{/classes}}
  {{/classifiers}}
 {{/images}}
</table>
{{/result}}
```
You can copy/paste this into the template node, if you like.

After deploying again, the user will see extra information on the classification page:

![azure cv add info](img/mg-brs-azure-cv-addon.png)
