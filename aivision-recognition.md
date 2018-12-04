# Using PowerAI Vision for image classification

An alternative to cloud-based image classification is available with 
[PowerAI Vision](https://developer.ibm.com/linuxonpower/deep-learning-powerai/technology-previews/powerai-vision/),
usually deployed as a service within your own data centre, allowing for ready access to internal-use 
images, documents, databases, etc. without the concerns for bandwidth/responsiveness and security that can arise with shipping
content to cloud-resident environments.

The following process sets up a PowerAI Vision instance that can be trained for custom classification purposes, 
and will show the simplicity with which a classifier can be created and used by a consumer application (in this case, NodeRED).

If you have access to a Power linux system of your own, then you can use the 
[local trial download](https://www-01.ibm.com/marketing/iwm/iwm/web/preLogin.do?source=mrs-eibmpair) to create your instance.

If you do _not_ have a Power Linux system to hand, you can use the
[IBM Partnerworld 3-day trial service](https://www.ibm.com/account/reg/us-en/signup?formid=urx-32004) to create a temporary instance.

## 3-day Trial on Partnerworld

*Note:-* this trial requires (free) registration with IBM Partnerworld - you will need to be a registered company to be eligible.

Once registered, and you receive the confirmation email that the trial has been activated, you should see a tile appear on 
your IBMid profile [dashboard](https://myibm.ibm.com/dashboard/):

![trail active](/img/powerai-vision-trial-3day.png)

Click on the `Launch` button to access the launch page:

![powerai-launch](/img/powerai-vision-trial-launch.png)

*Note:-* the name/IP address of this service varies during the trial - if the instance is suspended, and needs to be resumed,
a new IP address will more than likely be assigned, resulting in a change of hostname too. Any process that depends on this 
(such as the NodeRED application) will need to be kept up to date with the current IP address.

To access the training dialog for the AI Vision classifier, launch the "datasets" page:
`http://<IP Address>:9080/powerai-vision/index.html#!/datasets` - remembering to replace <IP Address> with the current hostname
from the trial summary table.

This should take you to a training page:

![training page](/img/powerai-vision-training.png)

This page is the same for the Partnerworld-based trial, the local Power Linux iunstallation trial, and a product deployment. 
The rest of this training process applies to any of these.

## Training the classifier
The first step is to add a training dataset - this will contain training images, associated with each class the service will be
required to classify.

![training-add-data](/img/powerai-vision-training-add-data.png)

Give your dataset a name, then start loading data to identify the first class of image content.
(in the AI Vision tool, "classes" are referred to as "categories")

Start with a "Sedans" category, and load up 15-20 images representing sedan cars:

![sedan-cat](/img/powerai-vision-train-cat-sedans.png)

![sedan-cars](/img/powerai-vision-train-cars-sedans.png)

Resulting in a populated category of "sedans".

![sedan-category](/img/powerai-vision-train-cat-sedans-loaded.png)

Go through the same process for different types of vehicle - there are samples for pickup trucks, and golf carts in the [/demo folder of this repository](/demo).

![trained-cats](/img/powerai-vision-train-cats.png)

Now the training images are loaded, the system needs to build a model using the underlying deep learning platform to generate a
classifier that will recognize (or not!) the different vehicle categories.

This is achieved by creating a new DL (deep learning) task, and setting it up to build an image classifier.

![select model](/img/powerai-vision-model-select.png)

Take the default settings; 

![build model](/img/powerai-vision-model-build.png)

you  will be prompted to accept that it may take some time to perform the task - click `Create New Task`

![create task](/img/powerai-vision-model-build-task.png)

After 10-15 mins (or less on a good day), you should see the results of the model training - 
ideally, this should show a reduction in training loss, and general rise and stabilisation of accuracy:

![model complete](/img/powerai-vision-model-complete.png)

The `Deploy and Test` button indicates the next step - this will create a web service that can be called to classify images.
This is the service endpoint that will be used by the NodeRED application.

## Deploying the classifier as a service

You will be prompted to run a test of the classifier through its deployment API - upload an image or two that you have not used
in the training datasets. to get an idea of accuracy.

![classifier test](/img/powerai-vision-model-test.png)

and then capture the (partial) API endpoint information from the `My Web APIs` view:

![classifier url](/img/powerai-vision-model-classifier-url.png)

This path (/dlapis/<classifier-id>) needs to be qualified with your AI Vision host path; for a 3-day trail service,
this will result in a classifier URL like:

```
http://nae-165-254-189-35.jarvice.com:9080/powerai-vision/api/dlapis/ca7380af-b616-4af9-b523-dbdfc65046ab
```
This URL will be used to *POST* images to the classifier service.

With an extra stage added to the Watson Visual Recognition example eslewhere in this repository, you can augment the
Watson classifier with your specific model results -

![ibm-watson-powerai](/img/ibmi-watson-powerai-visrec.png)




