package stepdefs

import io.cucumber.scala.{EN, ScalaDsl}
import org.openqa.selenium.{By, WebDriver, WebElement}
import org.openqa.selenium.chrome.ChromeDriver

class Login extends ScalaDsl with EN {

  val driver: WebDriver = new ChromeDriver()

  Given("""The user is on the Login Page""") { () =>
    //---- write your code ----
    driver.get("https://parabank.parasoft.com/parabank/index.htm")
  }
  When("""The user enters a valid username and password"""){ () =>

    driver.findElement(By.name("username")).sendKeys("john")
    driver.findElement(By.name("password")).sendKeys("demo")
  }
  And("""The user clicks on the login button"""){ () =>

    driver.findElement(By.cssSelector("#loginPanel > form > div:nth-child(5) > input")).click()
    Thread.sleep(2000)
  }
  Then("""The user should be logged in successfully"""){ () =>
    val actualHeader:String = driver.findElement(By.cssSelector("#showOverview > h1")).getText
    val expectedHeader:String = "Accounts Overview"
    // assertion
    if (actualHeader == expectedHeader){
      println("Login successfully")
    }
  }

}
