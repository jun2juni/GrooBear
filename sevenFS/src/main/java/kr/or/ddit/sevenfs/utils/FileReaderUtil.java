package kr.or.ddit.sevenfs.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.*;
import java.nio.charset.StandardCharsets;

@Component
public class FileReaderUtil {
    @Value("${file.save.abs.path}")
    private String absPath;

    public static void main(String[] args) {
        FileReaderUtil fileReaderUtil = new FileReaderUtil();
        String filePath = fileReaderUtil.absPath + "허성진_cors에러.txt";
        System.out.println(filePath);
        String s = fileReaderUtil.readFile(filePath, 100);

        System.out.println(s);
    }

    public String readFile(String filePath, Integer lineNum) {
        File file = new File(absPath + filePath);
        if (file.exists()) {
            try {
                BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file), StandardCharsets.UTF_8));
                StringBuffer sb = new StringBuffer();
                String line = null;
//                while (((line = br.readLine()) != null)) {
//                    sb.append(line);
//                    sb.append(line + "\r\n");
//                }

                for (int i = 0; i < lineNum; i++) {
                    line = br.readLine();
                    if (line == null) break;;

                    sb.append(line);
                    sb.append(line + "\r\n");

                }

                return sb.toString();

            } catch (FileNotFoundException e) {
                throw new RuntimeException(e);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        return "";
    }
}
