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
    'y3nGvd+W12k=')

WebUI.selectOptionByValue(findTestObject('Object Repository/Pricing-Test Plan Regresión Core/Page_Login/select_Select an option CANARY ISLAND'), 
    'IC', true)

WebUI.click(findTestObject('Object Repository/Pricing-Test Plan Regresión Core/Page_Login/button_Login'))

WebUI.waitForElementPresent(findTestObject('Pricing-Test Plan Regresión Core/Page_Login/div_Invalid credentials'), 3)

WebUI.waitForElementVisible(findTestObject('Pricing-Test Plan Regresión Core/Page_Login/div_Invalid credentials'), 3)

WebUI.closeBrowser()

