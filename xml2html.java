package xml2html;

import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;

public class xml2html {
	
	public static void main(String[] args) {
		//if(args.length >0){
			String xmlFilePath = args[0];
		//}
		
        //String xmlFilePath = "C:\\Program Files (x86)\\Jenkins\\workspace\\ToscaCI_AutomatedExecution_FST_Group1_TAMP\\results.xml";
        String xslFilePath = "E:\\Jenkins\\xml2html-main\\xml2html-main\\set2ToscaResults\\4if.xslt";
        String outputFilePath = "E:\\Jenkins\\results.html";
        convertXMLToHTML(xmlFilePath, xslFilePath, outputFilePath);
    }

    
    public static void convertXMLToHTML(String xmlFilePath, String xslFilePath, String outputFilePath) {
        try {
            // Create a TransformerFactory
            TransformerFactory transformerFactory = TransformerFactory.newInstance();

            // Load the XSLT stylesheet
            Source xslt = new StreamSource(new File(xslFilePath));

            // Create a Transformer for the XSLT transformation
            Transformer transformer = transformerFactory.newTransformer(xslt);

            // Load the XML input
            Source xml = new StreamSource(new File(xmlFilePath));

            // Perform the transformation and generate the HTML output
            Result output = new StreamResult(new File(outputFilePath));
            transformer.transform(xml, output);

            System.out.println("XML to HTML conversion completed successfully.");
        } catch (TransformerException e) {
            System.err.println("Error occurred during XML to HTML conversion: " + e.getMessage());
        }	
    }
}
