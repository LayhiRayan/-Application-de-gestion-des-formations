package util;

import java.util.Random;

public class CodeGenerator {
    public static String generateCode(int length) {
        String characters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        StringBuilder code = new StringBuilder();
        Random rnd = new Random();
        for (int i = 0; i < length; i++) {
            code.append(characters.charAt(rnd.nextInt(characters.length())));
        }
        return code.toString();
    }
}
