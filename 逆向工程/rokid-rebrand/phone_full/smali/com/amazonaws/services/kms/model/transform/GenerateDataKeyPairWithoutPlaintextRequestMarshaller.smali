.class public Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyPairWithoutPlaintextRequestMarshaller;
.super Ljava/lang/Object;
.source "GenerateDataKeyPairWithoutPlaintextRequestMarshaller.java"

# interfaces
.implements Lcom/amazonaws/transform/Marshaller;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/amazonaws/transform/Marshaller<",
        "Lcom/amazonaws/Request<",
        "Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;",
        ">;",
        "Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public marshall(Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;)Lcom/amazonaws/Request;
    .locals 10
    .param p1, "generateDataKeyPairWithoutPlaintextRequest"    # Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;",
            ")",
            "Lcom/amazonaws/Request<",
            "Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;",
            ">;"
        }
    .end annotation

    .line 49
    if-eqz p1, :cond_9

    .line 54
    new-instance v0, Lcom/amazonaws/DefaultRequest;

    const-string v1, "AWSKMS"

    invoke-direct {v0, p1, v1}, Lcom/amazonaws/DefaultRequest;-><init>(Lcom/amazonaws/AmazonWebServiceRequest;Ljava/lang/String;)V

    .line 56
    .local v0, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;>;"
    const-string v1, "TrentService.GenerateDataKeyPairWithoutPlaintext"

    .line 57
    .local v1, "target":Ljava/lang/String;
    const-string v2, "X-Amz-Target"

    invoke-interface {v0, v2, v1}, Lcom/amazonaws/Request;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    .line 58
    sget-object v2, Lcom/amazonaws/http/HttpMethodName;->POST:Lcom/amazonaws/http/HttpMethodName;

    invoke-interface {v0, v2}, Lcom/amazonaws/Request;->setHttpMethod(Lcom/amazonaws/http/HttpMethodName;)V

    .line 60
    const-string v2, "/"

    .line 61
    .local v2, "uriResourcePath":Ljava/lang/String;
    invoke-interface {v0, v2}, Lcom/amazonaws/Request;->setResourcePath(Ljava/lang/String;)V

    .line 63
    :try_start_0
    new-instance v3, Ljava/io/StringWriter;

    invoke-direct {v3}, Ljava/io/StringWriter;-><init>()V

    .line 64
    .local v3, "stringWriter":Ljava/io/StringWriter;
    invoke-static {v3}, Lcom/amazonaws/util/json/JsonUtils;->getJsonWriter(Ljava/io/Writer;)Lcom/amazonaws/util/json/AwsJsonWriter;

    move-result-object v4

    .line 65
    .local v4, "jsonWriter":Lcom/amazonaws/util/json/AwsJsonWriter;
    invoke-interface {v4}, Lcom/amazonaws/util/json/AwsJsonWriter;->beginObject()Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 67
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;->getEncryptionContext()Ljava/util/Map;

    move-result-object v5

    if-eqz v5, :cond_2

    .line 68
    nop

    .line 69
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;->getEncryptionContext()Ljava/util/Map;

    move-result-object v5

    .line 70
    .local v5, "encryptionContext":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    const-string v6, "EncryptionContext"

    invoke-interface {v4, v6}, Lcom/amazonaws/util/json/AwsJsonWriter;->name(Ljava/lang/String;)Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 71
    invoke-interface {v4}, Lcom/amazonaws/util/json/AwsJsonWriter;->beginObject()Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 72
    nop

    .line 73
    invoke-interface {v5}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v6

    .line 72
    invoke-interface {v6}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_1

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/util/Map$Entry;

    .line 74
    .local v7, "encryptionContextEntry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-interface {v7}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    .line 75
    .local v8, "encryptionContextValue":Ljava/lang/String;
    if-eqz v8, :cond_0

    .line 76
    invoke-interface {v7}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    invoke-interface {v4, v9}, Lcom/amazonaws/util/json/AwsJsonWriter;->name(Ljava/lang/String;)Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 77
    invoke-interface {v4, v8}, Lcom/amazonaws/util/json/AwsJsonWriter;->value(Ljava/lang/String;)Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 79
    .end local v7    # "encryptionContextEntry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v8    # "encryptionContextValue":Ljava/lang/String;
    :cond_0
    goto :goto_0

    .line 80
    :cond_1
    invoke-interface {v4}, Lcom/amazonaws/util/json/AwsJsonWriter;->endObject()Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 82
    .end local v5    # "encryptionContext":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_2
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;->getKeyId()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_3

    .line 83
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;->getKeyId()Ljava/lang/String;

    move-result-object v5

    .line 84
    .local v5, "keyId":Ljava/lang/String;
    const-string v6, "KeyId"

    invoke-interface {v4, v6}, Lcom/amazonaws/util/json/AwsJsonWriter;->name(Ljava/lang/String;)Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 85
    invoke-interface {v4, v5}, Lcom/amazonaws/util/json/AwsJsonWriter;->value(Ljava/lang/String;)Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 87
    .end local v5    # "keyId":Ljava/lang/String;
    :cond_3
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;->getKeyPairSpec()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_4

    .line 88
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;->getKeyPairSpec()Ljava/lang/String;

    move-result-object v5

    .line 89
    .local v5, "keyPairSpec":Ljava/lang/String;
    const-string v6, "KeyPairSpec"

    invoke-interface {v4, v6}, Lcom/amazonaws/util/json/AwsJsonWriter;->name(Ljava/lang/String;)Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 90
    invoke-interface {v4, v5}, Lcom/amazonaws/util/json/AwsJsonWriter;->value(Ljava/lang/String;)Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 92
    .end local v5    # "keyPairSpec":Ljava/lang/String;
    :cond_4
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v5

    if-eqz v5, :cond_7

    .line 93
    nop

    .line 94
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v5

    .line 95
    .local v5, "grantTokens":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    const-string v6, "GrantTokens"

    invoke-interface {v4, v6}, Lcom/amazonaws/util/json/AwsJsonWriter;->name(Ljava/lang/String;)Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 96
    invoke-interface {v4}, Lcom/amazonaws/util/json/AwsJsonWriter;->beginArray()Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 97
    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_1
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_6

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    .line 98
    .local v7, "grantTokensItem":Ljava/lang/String;
    if-eqz v7, :cond_5

    .line 99
    invoke-interface {v4, v7}, Lcom/amazonaws/util/json/AwsJsonWriter;->value(Ljava/lang/String;)Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 101
    .end local v7    # "grantTokensItem":Ljava/lang/String;
    :cond_5
    goto :goto_1

    .line 102
    :cond_6
    invoke-interface {v4}, Lcom/amazonaws/util/json/AwsJsonWriter;->endArray()Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 105
    .end local v5    # "grantTokens":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    :cond_7
    invoke-interface {v4}, Lcom/amazonaws/util/json/AwsJsonWriter;->endObject()Lcom/amazonaws/util/json/AwsJsonWriter;

    .line 106
    invoke-interface {v4}, Lcom/amazonaws/util/json/AwsJsonWriter;->close()V

    .line 107
    invoke-virtual {v3}, Ljava/io/StringWriter;->toString()Ljava/lang/String;

    move-result-object v5

    .line 108
    .local v5, "snippet":Ljava/lang/String;
    sget-object v6, Lcom/amazonaws/util/StringUtils;->UTF8:Ljava/nio/charset/Charset;

    invoke-virtual {v5, v6}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v6

    .line 109
    .local v6, "content":[B
    new-instance v7, Lcom/amazonaws/util/StringInputStream;

    invoke-direct {v7, v5}, Lcom/amazonaws/util/StringInputStream;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v7}, Lcom/amazonaws/Request;->setContent(Ljava/io/InputStream;)V

    .line 110
    const-string v7, "Content-Length"

    array-length v8, v6

    invoke-static {v8}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v8

    invoke-interface {v0, v7, v8}, Lcom/amazonaws/Request;->addHeader(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 114
    .end local v3    # "stringWriter":Ljava/io/StringWriter;
    .end local v4    # "jsonWriter":Lcom/amazonaws/util/json/AwsJsonWriter;
    .end local v5    # "snippet":Ljava/lang/String;
    .end local v6    # "content":[B
    nop

    .line 115
    invoke-interface {v0}, Lcom/amazonaws/Request;->getHeaders()Ljava/util/Map;

    move-result-object v3

    const-string v4, "Content-Type"

    invoke-interface {v3, v4}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_8

    .line 116
    const-string v3, "application/x-amz-json-1.1"

    invoke-interface {v0, v4, v3}, Lcom/amazonaws/Request;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    .line 119
    :cond_8
    return-object v0

    .line 111
    :catchall_0
    move-exception v3

    .line 112
    .local v3, "t":Ljava/lang/Throwable;
    new-instance v4, Lcom/amazonaws/AmazonClientException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Unable to marshall request to JSON: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 113
    invoke-virtual {v3}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5, v3}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v4

    .line 50
    .end local v0    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;>;"
    .end local v1    # "target":Ljava/lang/String;
    .end local v2    # "uriResourcePath":Ljava/lang/String;
    .end local v3    # "t":Ljava/lang/Throwable;
    :cond_9
    new-instance v0, Lcom/amazonaws/AmazonClientException;

    const-string v1, "Invalid argument passed to marshall(GenerateDataKeyPairWithoutPlaintextRequest)"

    invoke-direct {v0, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public bridge synthetic marshall(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 43
    check-cast p1, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;

    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyPairWithoutPlaintextRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;)Lcom/amazonaws/Request;

    move-result-object p1

    return-object p1
.end method
