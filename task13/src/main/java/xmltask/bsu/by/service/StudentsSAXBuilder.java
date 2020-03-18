package xmltask.bsu.by.service;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import xmltask.bsu.by.bean.Student;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import java.io.IOException;
import java.util.Set;

public class StudentsSAXBuilder {
    private static final Logger LOGGER = LogManager.getLogger();

    private Set<Student> students;
    private StudentHandler studentHandler;
    private XMLReader reader;

    public StudentsSAXBuilder() {
        studentHandler = new StudentHandler();
        try {
            SAXParserFactory parserFactory = SAXParserFactory.newInstance();
            SAXParser parser = parserFactory.newSAXParser();
            reader = parser.getXMLReader();
            reader.setContentHandler(studentHandler);
        } catch (SAXException e) {
            LOGGER.error(e.getMessage());
        } catch (ParserConfigurationException e) {
            LOGGER.error(e.getMessage());
        }
    }

    public Set<Student> getStudents() {
        return students;
    }

    public void buildSetStudents(String fileName) {
        try {
            reader.parse(fileName);
        } catch (IOException e) {
            LOGGER.error(e.getMessage());
        } catch (SAXException e) {
            LOGGER.error(e.getMessage());
        }
        students = studentHandler.getStudents();
    }
}