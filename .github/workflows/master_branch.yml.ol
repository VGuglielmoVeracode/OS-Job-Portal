name: Master Branch Workflow

on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

jobs:  
  policy-scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/upload-artifact@v2
        with:
          name: OS-Job-Portal.zip
          path: OS-Job-Portal.zip
      # - name: zip-contents
      #   run: |
      #     zip -r OS-Job-Portal.zip .
      
      - name: Veracode Upload and Scan Action Step
        uses: veracode/veracode-uploadandscan-action@master
        id: upload_and_scan
        with:
          appname: 'OS Job Portal'
          version: '${{ github.run_id }}'
          filepath: 'OS-Job-Portal.zip'
          vid: '${{ secrets.VERACODE_API_ID }}'
          vkey: '${{ secrets.VERACODE_API_KEY }}'
#           scantimeout: 15