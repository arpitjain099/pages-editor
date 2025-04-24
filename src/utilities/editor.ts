// standardize our editor features
import { lexicalEditor } from '@payloadcms/richtext-lexical'

export const editor = lexicalEditor({
        features: ({ defaultFeatures }) => [
          ...defaultFeatures,
        ],
      })
