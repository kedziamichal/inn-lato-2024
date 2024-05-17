import {api, LightningElement, track, wire} from 'lwc';
import {getFieldValue, getRecord} from "lightning/uiRecordApi";


import TAGS_FIELD from "@salesforce/schema/Contact.Tags__c";

import saveTags from "@salesforce/apex/TagController.saveTags"

export default class Tagger extends LightningElement {
    @api  recordId;
    tagColorValue = 'inProgress';
    tagNameValue = '';

    @track _tags = [];

    tmp = ['1', '2'];

    get tmp (){
        return 'dupa';
    }

    @wire(getRecord, {recordId: "$recordId", fields: [TAGS_FIELD]})
    wiredAccount({error, data}) {
        if (data) {
            this._tags = JSON.parse(getFieldValue(data, TAGS_FIELD));
            console.log(JSON.stringify(this.tags));
        } else if (error) {
            console.log(JSON.stringify(error));
        }
    }

    get tags() {
        return this._tags.map((val, index) => ({...val, tagId: index}));
    }

    get options() {
        return [
            {label: 'Red', value: 'slds-theme_error'},
            {label: 'Green', value: 'slds-theme_success'}
        ];
    }

    handleTagColorChange(event) {
        this.tagColorValue = event.detail.value;
    }

    handleTagNameChange(event) {
        this.tagNameValue = event.detail.value;
    }

    handleAddTags() {
        this._tags = [...this._tags, {name: this.tagNameValue, color: this.tagColorValue}];
    }

    handleRemoveTag(event) {
        this._tags = this._tags.filter((val, index) => event.detail !== index);
    }

    handleSaveTags() {
        saveTags({recordId: this.recordId, tags: JSON.stringify(this._tags)})
            .then(() => {
                console.log('OK');
            }).catch((error) => {
            console.log('NIE OK '+  JSON.stringify(error));
        });
    }
}