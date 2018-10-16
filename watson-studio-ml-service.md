# Creating a Machine learning service in Watson Studio

Let's step through the creation of a scoring service:

1. create a Watson Studio project
![add project](img/mg-brs--ws-add-project.png)
Select `Complete`, and click `OK`
 ![select Complete project](img/mg-brs-ws-add-prj-select.png)

1. Locate sample data for basic logistic prediction.
Click on `Community` in the top menu bar.
![find sample in community](img/mg-brs-add-data.png)
Select the `GoSales` dataset
![results](img/mg-brs-add-data-lr.png)
Click the `+` symbol in the bottom right corner of the dataset to add to the Project
![add to project](img/mg-brs-add-data-added.png)
![data added](img/mg-brs-ws-data-asset.png)

1. Now add a machine learning model to the project
![add ML instance](img/mg-brs-add-ml.png)
Click `+ New Watson Machine Learning model`
![Adding ML instance](img/mg-brs-add-ml-model.png)
Give it a name so you can find it again. You will see that at this stage there is no Machine Learning service associated with your new model - let's fix that. ** Note the `Reload` link here ...**
Click the `Associate a Machine Learning service instance` link

1. Create the IBM Cloud service to run the ML instance
![add new ML instance](img/mg-brs-add-ml-new.png)
Accept the defaults for Price plans, and click the `Create` button at the bottom
![create ML instance](img/mg-brs-add-ml-create.png)
and `Confirm`
![confirm ML instance](img/mg-brs-add-ml-confirm.png)

1. Back in the ML model creation page - click the `Reload` link and recognize the ML instance you just created.
![load ML instance into ](img/mg-brs-add-ml-reload.png)

1. Now select the Spark runtime for the model (there should only be one ...)
![add ML runtime](img/mg-brs-add-ml-runtime.png)
Select `Manual` for the data preparation choice, and click `Create`

1. Add the sample data to the ML model for training
![add data to ML model](img/mg-brs-add-ml-data.png)
Click `Next`

1. Now select a technique for to be used for scoring/predicting
![add ML technique](img/mg-brs-add-ml-techniq.png)
For the `Label column`, select `IS_TENT` - a yes/no label, so *Binary Classification* will be fine. Leave the feature colums to default to `All`. To perform the scoring, we add an "estimator".
![add ML estimator](img/mg-brs-add-ml-estimator.png)
![choose estimator](img/mg-brs-add-ml-est-select.png)
Select `Logistic Regression`, and Click `Add`
![estimated added](img/mg-brs-add-ml-techniq-ready.png)
Click `Next`
You should see a brief popup - `Training Models`, followed by the model training evaluation view
![status of trained model](img/mg-brs-add-ml-eval.png)
Click `Save`
1. Create a web service deployment of the model
![model overview](img/mg-brs-ml-overview.png)
The web service for scoring needs to be "deployed" - select the `Deployments` tab.
![select deployments](img/mg-brs-ml-deployments.png)
and click on `+ Add Deployment`
![add ML deployment](img/mg-brs-ml-deploy-name.png)
give your deployment a name, and click `Add`
![deployment added](img/mg-brs-ml-deploy-success.png)
The web service has been deployed and can now be used to score data. To dat tha, you will need to know some information about where to find it, and how to access it securely.
Click on the Model name link ("a tent" in this case) to get to the deplyment details, and do a quick test.

1. Testing the model
![quick test of model](img/mg-brs-ml-service-overview.png)
Click on the `Test` tab
![test data](img/mg-brs-ml-service-testdata.png)
Use other values to see the effect on the prediction:
  - Profession - Trades, Professional, Retired, Hospitality, Retail, Sales, Executive, Other
  - Marital_Status - Married, Single, Unspecified
  - Gender - M, F
  - Age - 17 to 69

1. Obtain the scoring endpoint information from the Implementation
![find scoring endpoint implementation](img/mg-brs-ml-service-implement-js.png)
Of key interest here is the `Scoring End-point` URL - this will be used to invoke the service from NodeRED (or any other client ...)
![capture url](img/mg-brs-ml-service-url.png)
Copy and save this in your favourite scratchpad/clipboard/notepad/notes service - you wil need it later.
If you take a look at the Javascript Code Snippet, you will find the section that shows how data needs to be formatted for presenting to the scoring service:
![scoring data format](img/mg-brs-ml-service-data-format.png) -- copy this to your scratchpad, too.
As you can see from the code snippet, you will also need the ML Service credentials from the IBM Cloud instance; let's get that now.

1. Get the ML username/password credentials for the scoring service
![get creds from IBM Cloud](img/mg-brs-ml-svc-creds.png)
From the top menu bar, select `Services` and `Watson Services` and locate the Machine Learning service instance.
![select ML instance](img/mg-brs-ml-svc-creds-instance.png)
Click service name (in this case "pm-20-brs") to see the detail view.
![view ML instance details](img/mg-brs-ml-svc-details.png)
Now view the `Service credentials`
![capture ML instance credentials](img/mg-brs-ml-svc-creds-detail.png)
Expanding the `View credentials` option for the `wdp-writer` key, you will find the **username** and **password** required for authenticating to the service, **and the host** for the authentication URL; again, save these to your scratchpad.
As the code snippet in the Implementation view shows, the authentication endpoint is the `/v3/identity/token` endpoint at the ML host.

## Summary
At this stage, you have a Machine Learning service running, with a scoring service which will predict the likelihood that a particular person/customer would buy a tent.

You have five pieces of information needed to call this service:
1. authentication endpoint URL
1. service username
1. service password
1. scoring service endpoint URL
1. format of the data to send for scoring

Now let's apply that to your NodeRED application ...

[Invoking ML Scoring from NodeRED](nodered-ml-scoring.md)
