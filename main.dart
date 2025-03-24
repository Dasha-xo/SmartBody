final encryptionKey = Hive.generateSecureKey();
final encryptedBox = await Hive.openBox(
  'inbodyData',
  encryptionCipher: HiveAesCipher(encryptionKey),
);
