package ft.training.by.service;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Arrays;
import java.util.Base64;
import java.util.Optional;

public final class PasswordUtilities {
    private static final Logger LOGGER = LogManager.getLogger();

    private static final SecureRandom SECURE_RANDOM = new SecureRandom();

    private static final int ITERATIONS = 65536;
    private static final int KEY_LENGTH = 128;
    private static final String ALGORITHM = "PBKDF2WithHmacSHA512";

    private PasswordUtilities() {
    }

    public static Optional<String> generateSalt(final int length) {
        if (length < 1) {
            LOGGER.error("Error in generateSalt(): length must be > 0");
            return Optional.empty();
        }
        byte[] salt = new byte[length];
        SECURE_RANDOM.nextBytes(salt);
        return Optional.of(Base64.getEncoder().encodeToString(salt));
    }

//    public static Optional<String> hashPassword(String password, String salt) {
//        char[] chars = password.toCharArray();
//        byte[] bytes = salt.getBytes();
//        PBEKeySpec spec = new PBEKeySpec(chars, bytes, ITERATIONS, KEY_LENGTH);
//        Arrays.fill(chars, Character.MIN_VALUE);
//        try {
//            SecretKeyFactory factory = SecretKeyFactory.getInstance(ALGORITHM);
//            byte[] securePassword = factory.generateSecret(spec).getEncoded();
//            return Optional.of(Base64.getEncoder().encodeToString(securePassword));
//
//        } catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
//            LOGGER.error("Exception encountered in hashPassword()");
//            return Optional.empty();
//        } finally {
//            spec.clearPassword();
//        }
//    }

//    public static boolean verifyPassword (String password, String key, String salt) {
//        Optional<String> optionalEncrypted = hashPassword(password, salt);
//        return optionalEncrypted.map(s -> s.equals(key)).orElse(false);
//    }

    public static Optional<String> hashPassword(String password) {
        char[] chars = password.toCharArray();
        byte[] bytes = new byte[16];
        PBEKeySpec spec = new PBEKeySpec(chars, bytes, ITERATIONS, KEY_LENGTH);
        Arrays.fill(chars, Character.MIN_VALUE);
        try {
            SecretKeyFactory factory = SecretKeyFactory.getInstance(ALGORITHM);
            byte[] securePassword = factory.generateSecret(spec).getEncoded();
            return Optional.of(Base64.getEncoder().encodeToString(securePassword));

        } catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
            LOGGER.error("Exception encountered in hashPassword()");
            return Optional.empty();
        } finally {
            spec.clearPassword();
        }
    }

    public static boolean verifyPassword(String password, String key) {
        Optional<String> optionalEncrypted = hashPassword(password);
        return optionalEncrypted.map(s -> s.equals(key)).orElse(false);
    }
}
