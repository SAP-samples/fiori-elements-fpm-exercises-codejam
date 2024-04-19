# Chapter 00 - Preparing the development environment

By the end of this chapter we will have prepared our development environment so that we can start developing our application.

## Steps

[1. Prerequisites](#1-prerequisites)<br>
[2. Navigate into your preferred directory](#2-navigate-into-your-preferred-directory)<br>
[3. Clone this repository](#3-clone-this-repository)<br>
[4. Navigate into the newly created directory](#4-navigate-into-the-newly-created-directory)<br>
[5. Open the directory](#5-open-the-directory)<br>

## 1. Prerequisites

To be able to follow the instructions in this repository you need to fulfill ***one*** of the following requirements:

- **Option 1:** You have access to the SAP Business Application Studio with the role collection `Business_Application_Studio_Developer` assigned to you in the SAP Business Technology Platform Cockpit. Create a new dev space of type `Full Stack Cloud Application` to get started.

> If you don't have access to the SAP Business Application Studio yet, check this tutorial on [how to get a free account on SAP BTP trial](https://developers.sap.com/tutorials/hcp-create-trial-account.html), from where you can [subscribe to the SAP Business Application Studio](https://developers.sap.com/tutorials/appstudio-onboarding.html).

- **Option 2:** You can use Visual Studio Code on your local machine. This is the complete list of tools you will need:
  - [Visual Studio Code](https://code.visualstudio.com/download)
  - [SAP Fiori Tools - Extension Pack](https://marketplace.visualstudio.com/items?itemName=SAPSE.sap-ux-fiori-tools-extension-pack) (Visual Studio Code extension)
  - [Node.js](https://nodejs.org/en/) (version 18 or higher) including `npm`
  - [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You need privileges to install `npm` packages from the [npm registry](https://www.npmjs.com/)

## 2. Navigate into your preferred directory

➡️ In your development environment (see [step 1](#1-prerequisites)), open a new terminal session and navigate to where you want to store this repository.

In case you are not familiar with navigation via the terminal, check out this [article](https://help.dreamhost.com/hc/en-us/articles/215465297-UNIX-commands-Working-with-directories).

## 3. Clone this repository

➡️ Execute the following command to clone this repository:

```bash
git clone https://github.com/SAP-samples/fiori-elements-fpm-exercises-codejam
```

We succesfully cloned this repository, for which a new directory has been created.

## 4. Navigate into the newly created directory

We want to navigate into the `bookshop/` directory inside newly created directory, as this is where we will build our application.

➡️ Execute the following command in the same terminal session:

```bash
cd fiori-elements-fpm-exercises-codejam/bookshop
```

## 5. Open the directory

➡️ Open the directory in the code editor of your choice, depending on the option you chose in [step 1](#1-prerequisites).

Continue to [Chapter 01 - Running the SAP CAP application](/chapters/01-run-cap-app/)
