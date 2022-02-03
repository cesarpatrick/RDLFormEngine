class Variables {
  static String prod() {
    return 'https://rdltr.com:8999/';
  }

  static String beta() {
    return 'http://localhost:8880/RDLWebService/ws/';
  }

  static String baseUrl() {
    return beta();
    // return beta();
  }

  static String getAuthUrl() {
    return baseUrl() + 'auth';
  }

  //QUESTION FORM URLS

  static String getQuestionSaveUrl() {
    return baseUrl() + 'formQuestion/save/';
  }

  static String getQuestionListUrl() {
    return baseUrl() + 'formQuestion/list/';
  }

  //TEMPLATES FORM URLS

  static String getTemplateSaveUrl() {
    return baseUrl() + 'formTemplate/save/';
  }

  static String getTemplateListUrl() {
    return baseUrl() + 'formTemplate/list/';
  }
}
