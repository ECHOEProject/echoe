# This script converts the XML corpus to plaintext.
# Paul Langeslag 2026.

from pathlib import Path
from lxml import etree

# GLOBAL PARAMETERS:
# Set False to suppress sentence identifiers:
sentence_identifiers = True
# Set to desired output folder:
plaintext_folder = Path.cwd().parent / 'plaintext'

# Normalization matrix
# (Tironian notes are language-dependent and are thus handled separately below):
substitutions = {
    'ę': 'æ',
    'ƿ': 'w',
    'ẏ': 'y',
    'ſ': 's',
    '': 's',
    'v': 'u',
    'j': 'i',
    'ꝛ': 'r',
    '&': 'et',
    '\uf149': 'þ',
    '\ue337': 'þ',
    '·': '',
    ' ': '',
    '\n': '',
    '\u2028': ''
}

# Token normalization:
def normalize(token):
    # Lowercase:
    token = token.lower()
    for k,v in substitutions.items():
        # Carry out replacements:
        token = token.replace(k, v)
    return token

# Discarding the content of unwanted XML elements:
def simplify(branch):
    discard = ['abbr', 'am', 'sic', 'del', 'note', 'surplus', 'orig', 'fw']  
    query = ['{http://www.tei-c.org/ns/1.0}' + i for i in discard]
    for hit in branch.iter(query):
        for element in hit.iter():
            element.text = ''
            element.tail = ''
    return branch

# Load the corpus into a multidimensional dictionary/list structure:
print('Loading XML corpus...')
parser = etree.XMLParser(remove_blank_text=True,resolve_entities=True)
xml_folder = Path.cwd().parent / 'xml'
Path(plaintext_folder).mkdir(parents=True, exist_ok=True)
corpus = dict()
for file in xml_folder.glob('*.xml'):
    basename = file.name[:-4]
    tree = etree.parse(file, parser=parser)
    root = simplify(tree.getroot())
    segments = dict()
    rubric_counter = 0
    for segment in root.iter('{http://www.tei-c.org/ns/1.0}head', '{http://www.tei-c.org/ns/1.0}s'):
        if segment.tag == '{http://www.tei-c.org/ns/1.0}head':
            rubric_counter += 1
            identifier = 'rubric' + str(rubric_counter)
        else:
            identifier = segment.get('{http://www.w3.org/XML/1998/namespace}id')
        tokens = []
        for token in segment.iter('{http://www.tei-c.org/ns/1.0}w'):
            if token.get('{http://www.w3.org/XML/1998/namespace}lang') == 'la' or token.xpath('ancestor::*[@xml:lang][1]/@xml:lang')[0] == 'la':
                token_string = normalize(etree.tostring(token, method='text', encoding='unicode')).replace('⁊', 'et').replace('⹒', 'et')
            else:
                token_string = normalize(etree.tostring(token, method='text', encoding='unicode')).replace('⁊', 'and').replace('⹒', 'and')
            # If a word element is marked as the last part of a word, add its text content to the preceding token:
            if token.get('part') == 'F':
                position = len(tokens)-1
                tokens[position] = tokens[position] + token_string
            else:
                tokens.append(token_string)
        segments[identifier] = tokens
    corpus[basename] = segments
        
# Output to disk:
print('Writing plaintext corpus...')
for ref,doc in corpus.items():
    target_file = Path(plaintext_folder / str(ref + '.txt'))
    previous_identifier = ''
    prior_content = False
    with open(target_file, 'w') as f:
        for identifier,tokens in doc.items():
            if 'rubric' in identifier and (prior_content == False or 'rubric' in previous_identifier):
                line = ' '.join(tokens) + '\n\n'
            elif 'rubric' in identifier:
                line = '\n' + ' '.join(tokens) + '\n\n'
            elif sentence_identifiers == False:
                line = ' '.join(tokens) + '\n'
            else:
                line = identifier[1:] + ': ' + ' '.join(tokens) + '\n'
            line = line.replace('  ', ' ')
            f.write(line)
            previous_identifier = identifier
            prior_content = True

print(f'Done; now see {str(plaintext_folder)}.')
