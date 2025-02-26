import com.kms.katalon.core.main.TestCaseMain
import com.kms.katalon.core.logging.KeywordLogger
import com.kms.katalon.core.testcase.TestCaseBinding
import com.kms.katalon.core.driver.internal.DriverCleanerCollector
import com.kms.katalon.core.model.FailureHandling
import com.kms.katalon.core.configuration.RunConfiguration
import com.kms.katalon.core.webui.contribution.WebUiDriverCleaner
import com.kms.katalon.core.mobile.contribution.MobileDriverCleaner
import com.kms.katalon.core.cucumber.keyword.internal.CucumberDriverCleaner
import com.kms.katalon.core.windows.keyword.contribution.WindowsDriverCleaner
import com.kms.katalon.core.testng.keyword.internal.TestNGDriverCleaner


DriverCleanerCollector.getInstance().addDriverCleaner(new com.kms.katalon.core.webui.contribution.WebUiDriverCleaner())
DriverCleanerCollector.getInstance().addDriverCleaner(new com.kms.katalon.core.mobile.contribution.MobileDriverCleaner())
DriverCleanerCollector.getInstance().addDriverCleaner(new com.kms.katalon.core.cucumber.keyword.internal.CucumberDriverCleaner())
DriverCleanerCollector.getInstance().addDriverCleaner(new com.kms.katalon.core.windows.keyword.contribution.WindowsDriverCleaner())
DriverCleanerCollector.getInstance().addDriverCleaner(new com.kms.katalon.core.testng.keyword.internal.TestNGDriverCleaner())


RunConfiguration.setExecutionSettingFile('/var/folders/sz/p5ln5r2n5gbcxzfd8386td5h0000gn/T/Katalon/Test Cases/PRICING-Test Plan Regresi\u00F3n Core/P25-XXXX-DELEGACIONES-Visualizar AgrupDelegaciones/20241209_181910/execution.properties')

TestCaseMain.beforeStart()

        TestCaseMain.runTestCase('Test Cases/PRICING-Test Plan Regresión Core/P25-XXXX-DELEGACIONES-Visualizar AgrupDelegaciones', new TestCaseBinding('Test Cases/PRICING-Test Plan Regresión Core/P25-XXXX-DELEGACIONES-Visualizar AgrupDelegaciones',[:]), FailureHandling.STOP_ON_FAILURE , false)
    
