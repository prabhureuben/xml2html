package xml2html;

import org.apache.xalan.processor.TransformerFactoryImpl;

import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;

public class ConvertXml2Html {
	
	
	public static void main(String[] args) {
        String xmlFilePath = "D:\\xmltohtmlplugin\\xmlandxstfiles\\set2ToscaResults\\results.xml";
        String xslFilePath = "D:\\xmltohtmlplugin\\xmlandxstfiles\\set2ToscaResults\\model.xslt";
        String outputFilePath = "D:\\xmltohtmlplugin\\xmlandxstfiles\\set2ToscaResults\\set2.html";
        convertXMLToHTML(xmlFilePath, xslFilePath, outputFilePath);
    }

    
    public static void convertXMLToHTML(String xmlFilePath, String xslFilePath, String outputFilePath) {
        try {
            // Create a TransformerFactory
            TransformerFactory transformerFactory = new TransformerFactoryImpl();

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
