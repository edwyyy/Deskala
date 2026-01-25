const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

const CHARACTER_SETS = {
  lowecase: 'abcdefghijklmnopqrstuvwxyz',
  uppercase: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
  Numbers: '1234567890',
  Symbols: '!@#$%^&*',
};

function generatePassword(length, options) {
  let charset = '';
  const { includeLowercase, includeUppercase, includeNumbers, includeSymbols } = options;

  if (includeLowercase) charset += CHARACTER_SETS.lowecase;
  if (includeUppercase) charset += CHARACTER_SETS.uppercase;
  if (includeNumbers) charset += CHARACTER_SETS.Numbers;
  if (includeSymbols) charset += CHARACTER_SETS.Symbols;

  if (charset === '') {
    throw new Error('At least one character type must be selected.');
  }

  let password = '';
  for (let i = 0; i < length; i += 1) {
    const randomIndex = Math.floor(Math.random() * charset.length);
    password += charset[randomIndex];
  }

  return password;
}

function calculatePasswordStrength(password) {
  let strength = 0;

  if (password.length >= 12) strength += 2;
  else if (password.length >= 8) strength += 1;

  if (/[a-z]/.test(password)) strength += 1;
  if (/[A-Z]/.test(password)) strength += 1;
  if (/[0-9]/.test(password)) strength += 1;
  if (/[!@#$%^&*]/.test(password)) strength += 1;

  if (strength >= 5) return 'Strong';
  if (strength >= 3) return 'Medium';
  return 'Weak';
}

function promptUser(question) {
  return new Promise((resolve) => {
    rl.question(question, (answer) => {
      resolve(answer);
    });
  });
}

async function main() {
  console.log('\n===Welcome to the Password Generator!===\n');

  const lengthInput = await promptUser('Enter password length (8-128):');
  const length = parseInt(lengthInput, 10);

  if (Number.isNaN(length) || length < 8 || length > 128) {
    console.log('Invalid length. Please enter a number between 8 and 128.');
    rl.close();
    return;
  }

  const lowercase = await promptUser('Include lowercase letters? (y/n):');
  const uppercase = await promptUser('Include uppercase letters? (y/n):');
  const numbers = await promptUser('Include numbers? (y/n):');
  const symbols = await promptUser('Include symbols? (y/n):');

  const options = {
    includeLowercase: lowercase.toLowerCase() === 'y',
    includeUppercase: uppercase.toLowerCase() === 'y',
    includeNumbers: numbers.toLowerCase() === 'y',
    includeSymbols: symbols.toLowerCase() === 'y',
  };

  try {
    const password = generatePassword(length, options);
    const strength = calculatePasswordStrength(password);

    console.log('\n===Generated Password===\n');
    console.log(`\nGenerated Password: ${password}`);
    console.log(`Strength: ${strength}\n`);
    console.log(`========================\n`);
  } catch (error) {
    console.log(`Error: ${error.message}`);
  }
  rl.close();
}

main();
