# Azure Cognitive services with Nodered

now that you have the IBM Watson Cogntive services working in NodeRED,
let's see what would be needed to do the same/similar with Microsot Azure Cognitive Services.

You will need to add a [Computer Vision](https://azure.microsoft.com/en-us/services/cognitive-services/directory/vision/) service subscription
to your Azure account. We will use a limited free service subscription for this.

Let's start with create the computer vision resoucre in the Azure portal
![azure portal - cv](img/mg-brs-azure-cv-select.png)
Select "Computer Vision"
![azure cv create](img/mg-brs-azure-cv-create.png)
Click `Create`
![azure cv settings](img/mg-brs-azure-cv-settings.png)
**Note** that the Location property has been overidden to "West US" -
this is necessary for the current version of the Azure NodeRED nodes,
which do not yet provide a means of selecting different regional endpoints.
