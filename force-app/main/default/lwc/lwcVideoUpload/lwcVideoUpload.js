import { LightningElement , wire , track , api } from 'lwc';
import getVideoDisplayPermission from '@salesforce/apex/VideoHelper.checkUserHasPermissionToWatchVideo';
import getVideoUploadPermission from '@salesforce/apex/VideoHelper.checkUserHasPermissionToUploadVideo';
import uploadVideoInS3 from '@salesforce/apex/VideoHelper.uploadVideoToS3Bucket';
import readVideoFile from '@salesforce/apex/VideoHelper.getUploadedVideoRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
export default class LwcVideoUpload extends LightningElement {
    @track
    displayVideo;
    fileEndPoint;
    buttonVariant='Brand';
    hideOrShow = 'Hide';
    selectedFilesToUpload = []; //store selected files
    @track showSpinner = false; //used for when to show spinner
    @track fileName; //to display the selected file name
    @track tableData; //to display the uploaded file and link to AWS
    file; //holding file instance
    myFile;    
    fileType;//holding file type
    fileReaderObj;
    base64FileData;
    @wire(getVideoDisplayPermission)
    videoDisplayReadPermission
    @wire(getVideoUploadPermission)
    videoUploadPermission
    @wire(readVideoFile)
    wireDisplayVideo(result){
        this.displayVideo = result;
        const{ data , error } = result;
        this.isDsiplayVideo = false;
        if(result.data){
            if(result.data.File_URL__c != null && result.data.File_URL__c != undefined){
                this.fileEndPoint = result.data.File_URL__c;
                if(this.videoUploadPermission){
                    this.isDsiplayVideo = true;
                }else{
                    this.isDsiplayVideo = result.data.Is_Visible__c;
                }
            }
        }
    }
    hideOrShowHandler(event){

    }
    uploadVideoHandler(event){

    }
    publishVideoHandler(event){

    }
    cancelPublishVideoHandler(event){

    }
    handleSelectedFiles(event) {
        if(event.target.files.length > 0) {
            this.selectedFilesToUpload = event.target.files;
            this.fileName = this.selectedFilesToUpload[0].name;
            this.fileType = this.selectedFilesToUpload[0].type;
            console.log('fileName=' + this.fileName);
            console.log('fileType=' + this.fileType);
            alert(this.fileName);
            alert(this.fileType);
            this.handleFileUpload();
        }
    }
        //parsing the file and prepare for upload.
        handleFileUpload(){
            if(this.selectedFilesToUpload.length > 0) {
                this.showSpinner = true;
                alert(this.selectedFilesToUpload[0]);
                this.file = this.selectedFilesToUpload[0];
                //create an intance of File
                this.fileReaderObj = new FileReader();
    
                //this callback function in for fileReaderObj.readAsDataURL
                this.fileReaderObj.onloadend = (() => {
                    //get the uploaded file in base64 format
                    let fileContents = this.fileReaderObj.result;
                    fileContents = fileContents.substr(fileContents.indexOf(',')+1)
                    
                    //read the file chunkwise
                    let sliceSize = 1024;           
                    let byteCharacters = atob(fileContents);
                    let bytesLength = byteCharacters.length;
                    let slicesCount = Math.ceil(bytesLength / sliceSize);                
                    let byteArrays = new Array(slicesCount);
                    for (let sliceIndex = 0; sliceIndex < slicesCount; ++sliceIndex) {
                        let begin = sliceIndex * sliceSize;
                        let end = Math.min(begin + sliceSize, bytesLength);                    
                        let bytes = new Array(end - begin);
                        for (let offset = begin, i = 0 ; offset < end; ++i, ++offset) {
                            bytes[i] = byteCharacters[offset].charCodeAt(0);                        
                        }
                        byteArrays[sliceIndex] = new Uint8Array(bytes);                    
                    }
                    
                    //from arraybuffer create a File instance
                    this.myFile =  new File(byteArrays, this.fileName, { type: this.fileType });
                    
                    //callback for final base64 String format
                    let reader = new FileReader();
                    reader.onloadend = (() => {
                        let base64data = reader.result;
                        this.base64FileData = base64data.substr(base64data.indexOf(',')+1); 
                        this.fileUpload();
                    });
                    reader.readAsDataURL(this.myFile);                                 
                });
                this.fileReaderObj.readAsDataURL(this.file);            
            }
            else {
                this.fileName = 'Please select a file to upload!';
            }
        }
    
        //this method calls Apex's controller to upload file in AWS
        fileUpload(){
            
            //implicit call to apex
            alert('File Upload');
            alert('this.file.name='+this.file.name);
            alert('this.file.type='+this.file.type);
            uploadVideoInS3({
                            fileName: this.file.name, 
                            fileType: this.file.type,
                            fileContent: encodeURIComponent(this.base64FileData)})
            .then(result => {
                console.log('Upload result = ' +result);            
                this.fileName = this.fileName + ' - Uploaded Successfully';
                //call to show uploaded files
                //this.getUploadedFiles(); 
                this.showSpinner = false;
                // Showing Success message after uploading
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message: this.file.name + ' - Uploaded Successfully!!!',
                        variant: 'success',
                    }),
                );
            })
            .catch(error => {
                // Error to show during upload
                window.console.log(error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error in uploading File',
                        message: error.message,
                        variant: 'error',
                    }),
                );
                this.showSpinner = false;
            });        
        }
}