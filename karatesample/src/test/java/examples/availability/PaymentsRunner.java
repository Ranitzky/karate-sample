package examples.availability;

import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;
import com.intuit.karate.KarateOptions;

@RunWith(Karate.class)
@KarateOptions(features = "classpath:examples/availability/payments.feature")
public class PaymentsRunner {

}