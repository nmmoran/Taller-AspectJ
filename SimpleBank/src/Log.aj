import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.Calendar;
import java.util.Date;

public aspect Log {
	
    Date fecha = new Date();
    BufferedWriter bw;
    File file = new File("log.txt");
    Calendar cal = Calendar.getInstance();
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    pointcut success() : call(* money*(..) );
    after() : success() {
    	try {
    		if (!file.exists()) {
    		file.createNewFile();
    		}
    		FileWriter fw = new FileWriter(file,true);
    		BufferedWriter bw = new BufferedWriter(fw);
    		if (thisJoinPointStaticPart.getSignature().getName().equals("moneyMakeTransaction")) {
    		System.out.println("Deposito Realizado "+fecha);
    		bw.write("Deposito Realizado "+fecha + " \n");
    		}
    		else {
    		System.out.println("Retiro Realizado " + fecha);
    		bw.write("Retiro Realizado " + fecha + " \n");
    		}bw.close();
    		} catch (Exception e) {
    		e.printStackTrace();
    		}
    	System.out.println("**** Transaction completed ****");
    }
}