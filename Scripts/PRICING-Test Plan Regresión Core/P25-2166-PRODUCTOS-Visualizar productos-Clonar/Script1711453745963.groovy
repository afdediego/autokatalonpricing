import static com.kms.katalon.core.checkpoint.CheckpointFactory.findCheckpoint
import static com.kms.katalon.core.testcase.TestCaseFactory.findTestCase
import static com.kms.katalon.core.testdata.TestDataFactory.findTestData
import static com.kms.katalon.core.testobject.ObjectRepository.findTestObject
import static com.kms.katalon.core.testobject.ObjectRepository.findWindowsObject
import com.kms.katalon.core.checkpoint.Checkpoint as Checkpoint
import com.kms.katalon.core.cucumber.keyword.CucumberBuiltinKeywords as CucumberKW
import com.kms.katalon.core.mobile.keyword.MobileBuiltInKeywords as Mobile
import com.kms.katalon.core.model.FailureHandling as FailureHandling
import com.kms.katalon.core.testcase.TestCase as TestCase
import com.kms.katalon.core.testdata.TestData as TestData
import com.kms.katalon.core.testng.keyword.TestNGBuiltinKeywords as TestNGKW
import com.kms.katalon.core.testobject.TestObject as TestObject
import com.kms.katalon.core.webservice.keyword.WSBuiltInKeywords as WS
import com.kms.katalon.core.webui.keyword.WebUiBuiltInKeywords as WebUI
import com.kms.katalon.core.windows.keyword.WindowsBuiltinKeywords as Windows
import internal.GlobalVariable as GlobalVariable
import org.openqa.selenium.Keys as Keys

WebUI.openBrowser('')

WebUI.navigateToUrl('https://pre-sales.recordgo.cloud/login')

WebUI.maximizeWindow()

WebUI.setText(findTestObject('Pricing-Test Plan Regresión Core/Page_Login/input_Log in to your account__username'), 'antonio.diego')

WebUI.setEncryptedText(findTestObject('Object Repository/Pricing-Test Plan Regresión Core/Page_Login/input_Log in to your account__password'), 
    '4WoE78dHD36JvULd0ZrVWg==')

WebUI.selectOptionByValue(findTestObject('Object Repository/Pricing-Test Plan Regresión Core/Page_Login/select_Select an option CANARY ISLAND'), 
    'IC', true)

WebUI.click(findTestObject('Pricing-Test Plan Regresión Core/Page_Login/button_Login'))

WebUI.waitForElementVisible(findTestObject('Pricing-Test Plan Regresión Core/Page_PRICING/img'), 5)

WebUI.waitForElementVisible(findTestObject('Pricing-Test Plan Regresión Core/Page_PRICING/span_PRODUCTOS'), 5)

WebUI.click(findTestObject('Pricing-Test Plan Regresión Core/Page_PRICING/span_PRODUCTOS'))

WebUI.waitForElementVisible(findTestObject('Pricing-Test Plan Regresión Core/Page_PRICING/span_Producto'), 5)

WebUI.click(findTestObject('Pricing-Test Plan Regresión Core/Page_PRICING/span_Producto'))

WebUI.waitForElementVisible(findTestObject('Pricing-Test Plan Regresión Core/Page_PRICING/span_Visualizar'), 5)

WebUI.click(findTestObject('Pricing-Test Plan Regresión Core/Page_PRICING/span_Visualizar'))

WebUI.waitForElementPresent(findTestObject('Pricing-Test Plan Regresión Core/Page_Visualizar PRODUCTOS/div_Cdigo'), 6)

WebUI.waitForElementPresent(findTestObject('Pricing-Test Plan Regresión Core/Page_Visualizar PRODUCTOS/div_Opciones'), 6)

WebUI.waitForElementPresent(findTestObject('Pricing-Test Plan Regresión Core/Page_Visualizar PRODUCTOS/button_Filtros'), 
    6)

WebUI.waitForElementPresent(findTestObject('Pricing-Test Plan Regresión Core/Page_Visualizar COMPLEMENTOS/IconoHojaClonarComplemento'), 
    5)

WebUI.doubleClick(findTestObject('Pricing-Test Plan Regresión Core/Page_Visualizar COMPLEMENTOS/IconoHojaClonarComplemento'))

WebUI.waitForElementPresent(findTestObject('Pricing-Test Plan Regresión Core/Page_Visualizar PRODUCTOS/h3_Clonar producto'), 
    4)

WebUI.verifyElementPresent(findTestObject('Pricing-Test Plan Regresión Core/Page_Visualizar PRODUCTOS/h3_Clonar producto'), 
    4)

WebUI.waitForElementPresent(findTestObject('Pricing-Test Plan Regresión Core/Page_Visualizar PRODUCTOS/button_CancelarClonarProduct'), 
    5)

WebUI.takeScreenshot('P-25-2166')

WebUI.focus(findTestObject('Pricing-Test Plan Regresión Core/Page_Visualizar PRODUCTOS/button_CancelarClonarProduct'), FailureHandling.STOP_ON_FAILURE)

WebUI.verifyElementPresent(findTestObject('Pricing-Test Plan Regresión Core/Page_Visualizar PRODUCTOS/button_CancelarClonarProduct'), 
    5)

WebUI.doubleClick(findTestObject('Pricing-Test Plan Regresión Core/Page_Visualizar PRODUCTOS/button_CancelarClonarProduct'))

WebUI.waitForElementPresent(findTestObject('Pricing-Test Plan Regresión Core/Page_Visualizar PRODUCTOS/h1_Registros totales'), 
    5)

WebUI.verifyElementPresent(findTestObject('Pricing-Test Plan Regresión Core/Page_Visualizar PRODUCTOS/h1_Registros totales'), 
    5)

WebUI.closeBrowser()

