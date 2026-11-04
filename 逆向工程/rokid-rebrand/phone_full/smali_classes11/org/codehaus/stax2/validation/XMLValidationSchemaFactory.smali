.class public abstract Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;
.super Ljava/lang/Object;
.source "XMLValidationSchemaFactory.java"


# static fields
.field public static final INTERNAL_ID_SCHEMA_DTD:Ljava/lang/String; = "dtd"

.field public static final INTERNAL_ID_SCHEMA_RELAXNG:Ljava/lang/String; = "relaxng"

.field public static final INTERNAL_ID_SCHEMA_TREX:Ljava/lang/String; = "trex"

.field public static final INTERNAL_ID_SCHEMA_W3C:Ljava/lang/String; = "w3c"

.field static final JAXP_PROP_FILENAME:Ljava/lang/String; = "jaxp.properties"

.field public static final P_ENABLE_CACHING:Ljava/lang/String; = "org.codehaus2.stax2.validation.enableCaching"

.field public static final P_IS_NAMESPACE_AWARE:Ljava/lang/String; = "org.codehaus2.stax2.validation.isNamespaceAware"

.field public static final SERVICE_DEFINITION_PATH:Ljava/lang/String; = "META-INF/services/org.codehaus.stax2.validation.XMLValidationSchemaFactory."

.field public static final SYSTEM_PROPERTY_FOR_IMPL:Ljava/lang/String; = "org.codehaus.stax2.validation.XMLValidationSchemaFactory."

.field static final sSchemaIds:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field protected final mSchemaType:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 35
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;->sSchemaIds:Ljava/util/HashMap;

    .line 37
    sget-object v0, Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;->sSchemaIds:Ljava/util/HashMap;

    const-string v1, "http://www.w3.org/XML/1998/namespace"

    const-string v2, "dtd"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 38
    sget-object v0, Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;->sSchemaIds:Ljava/util/HashMap;

    const-string v1, "http://relaxng.org/ns/structure/0.9"

    const-string v2, "relaxng"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 39
    sget-object v0, Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;->sSchemaIds:Ljava/util/HashMap;

    const-string v1, "http://www.w3.org/2001/XMLSchema"

    const-string v2, "w3c"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 40
    sget-object v0, Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;->sSchemaIds:Ljava/util/HashMap;

    const-string v1, "http://www.thaiopensource.com/trex"

    const-string v2, "trex"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 41
    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "st"    # Ljava/lang/String;

    .line 97
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 98
    iput-object p1, p0, Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;->mSchemaType:Ljava/lang/String;

    .line 99
    return-void
.end method

.method private static createNewInstance(Ljava/lang/ClassLoader;Ljava/lang/String;)Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;
    .locals 4
    .param p0, "cloader"    # Ljava/lang/ClassLoader;
    .param p1, "clsName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/FactoryConfigurationError;
        }
    .end annotation

    .line 301
    const-string v0, "XMLValidationSchemaFactory implementation \'"

    if-nez p0, :cond_0

    .line 302
    :try_start_0
    invoke-static {p1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .local v1, "factoryClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    goto :goto_0

    .line 304
    .end local v1    # "factoryClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :cond_0
    invoke-virtual {p0, p1}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 306
    .restart local v1    # "factoryClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :goto_0
    invoke-virtual {v1}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    .line 310
    .end local v1    # "factoryClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :catch_0
    move-exception v1

    .line 311
    .local v1, "x":Ljava/lang/Exception;
    new-instance v2, Ljavax/xml/stream/FactoryConfigurationError;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "\' could not be instantiated: "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v0, v1}, Ljavax/xml/stream/FactoryConfigurationError;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v2

    .line 307
    .end local v1    # "x":Ljava/lang/Exception;
    :catch_1
    move-exception v1

    .line 308
    .local v1, "x":Ljava/lang/ClassNotFoundException;
    new-instance v2, Ljavax/xml/stream/FactoryConfigurationError;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "\' not found (missing jar in classpath?)"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v0, v1}, Ljavax/xml/stream/FactoryConfigurationError;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v2
.end method

.method public static newInstance(Ljava/lang/String;)Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;
    .locals 1
    .param p0, "schemaType"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/FactoryConfigurationError;
        }
    .end annotation

    .line 116
    nop

    .line 117
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->getContextClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    .line 116
    invoke-static {p0, v0}, Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;->newInstance(Ljava/lang/String;Ljava/lang/ClassLoader;)Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;

    move-result-object v0

    return-object v0
.end method

.method public static newInstance(Ljava/lang/String;Ljava/lang/ClassLoader;)Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;
    .locals 13
    .param p0, "schemaType"    # Ljava/lang/String;
    .param p1, "classLoader"    # Ljava/lang/ClassLoader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/FactoryConfigurationError;
        }
    .end annotation

    .line 126
    sget-object v0, Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;->sSchemaIds:Ljava/util/HashMap;

    invoke-virtual {v0, p0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 127
    .local v0, "internalId":Ljava/lang/String;
    const-string v1, "\')"

    if-eqz v0, :cond_9

    .line 131
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "org.codehaus.stax2.validation.XMLValidationSchemaFactory."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 132
    .local v2, "propertyId":Ljava/lang/String;
    const/4 v3, 0x0

    .line 138
    .local v3, "secEx":Ljava/lang/SecurityException;
    :try_start_0
    invoke-static {v2}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 139
    .local v4, "clsName":Ljava/lang/String;
    if-eqz v4, :cond_0

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v5

    if-lez v5, :cond_0

    .line 140
    invoke-static {p1, v4}, Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;->createNewInstance(Ljava/lang/ClassLoader;Ljava/lang/String;)Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 145
    .end local v4    # "clsName":Ljava/lang/String;
    :cond_0
    goto :goto_0

    .line 142
    :catch_0
    move-exception v4

    .line 144
    .local v4, "se":Ljava/lang/SecurityException;
    move-object v3, v4

    .line 152
    .end local v4    # "se":Ljava/lang/SecurityException;
    :goto_0
    :try_start_1
    const-string v4, "java.home"

    invoke-static {v4}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 153
    .local v4, "home":Ljava/lang/String;
    new-instance v5, Ljava/io/File;

    invoke-direct {v5, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 156
    .local v5, "f":Ljava/io/File;
    new-instance v6, Ljava/io/File;

    const-string v7, "lib"

    invoke-direct {v6, v5, v7}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    move-object v5, v6

    .line 157
    new-instance v6, Ljava/io/File;

    const-string v7, "jaxp.properties"

    invoke-direct {v6, v5, v7}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    move-object v5, v6

    .line 158
    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v6
    :try_end_1
    .catch Ljava/lang/SecurityException; {:try_start_1 .. :try_end_1} :catch_2

    if-eqz v6, :cond_2

    .line 160
    :try_start_2
    new-instance v6, Ljava/util/Properties;

    invoke-direct {v6}, Ljava/util/Properties;-><init>()V

    .line 161
    .local v6, "props":Ljava/util/Properties;
    new-instance v7, Ljava/io/FileInputStream;

    invoke-direct {v7, v5}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-virtual {v6, v7}, Ljava/util/Properties;->load(Ljava/io/InputStream;)V

    .line 162
    invoke-virtual {v6, v2}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 163
    .local v7, "clsName":Ljava/lang/String;
    if-eqz v7, :cond_1

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v8

    if-lez v8, :cond_1

    .line 164
    invoke-static {p1, v7}, Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;->createNewInstance(Ljava/lang/ClassLoader;Ljava/lang/String;)Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;

    move-result-object v1
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/SecurityException; {:try_start_2 .. :try_end_2} :catch_2

    return-object v1

    .line 168
    .end local v6    # "props":Ljava/util/Properties;
    .end local v7    # "clsName":Ljava/lang/String;
    :cond_1
    goto :goto_1

    .line 166
    :catch_1
    move-exception v6

    .line 173
    .end local v4    # "home":Ljava/lang/String;
    .end local v5    # "f":Ljava/io/File;
    :cond_2
    :goto_1
    goto :goto_2

    .line 170
    :catch_2
    move-exception v4

    .line 172
    .local v4, "se":Ljava/lang/SecurityException;
    move-object v3, v4

    .line 178
    .end local v4    # "se":Ljava/lang/SecurityException;
    :goto_2
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "META-INF/services/org.codehaus.stax2.validation.XMLValidationSchemaFactory."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 182
    .local v4, "path":Ljava/lang/String;
    if-nez p1, :cond_3

    .line 183
    :try_start_3
    invoke-static {v4}, Ljava/lang/ClassLoader;->getSystemResources(Ljava/lang/String;)Ljava/util/Enumeration;

    move-result-object v5

    .local v5, "en":Ljava/util/Enumeration;, "Ljava/util/Enumeration<*>;"
    goto :goto_3

    .line 185
    .end local v5    # "en":Ljava/util/Enumeration;, "Ljava/util/Enumeration<*>;"
    :cond_3
    invoke-virtual {p1, v4}, Ljava/lang/ClassLoader;->getResources(Ljava/lang/String;)Ljava/util/Enumeration;

    move-result-object v5

    .line 188
    .restart local v5    # "en":Ljava/util/Enumeration;, "Ljava/util/Enumeration<*>;"
    :goto_3
    if-eqz v5, :cond_7

    .line 189
    :goto_4
    invoke-interface {v5}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v6

    if-eqz v6, :cond_7

    .line 190
    invoke-interface {v5}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/net/URL;

    .line 191
    .local v6, "url":Ljava/net/URL;
    invoke-virtual {v6}, Ljava/net/URL;->openStream()Ljava/io/InputStream;

    move-result-object v7

    .line 192
    .local v7, "is":Ljava/io/InputStream;
    new-instance v8, Ljava/io/BufferedReader;

    new-instance v9, Ljava/io/InputStreamReader;

    const-string v10, "ISO-8859-1"

    invoke-direct {v9, v7, v10}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {v8, v9}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :try_end_3
    .catch Ljava/lang/SecurityException; {:try_start_3 .. :try_end_3} :catch_4
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_3

    .line 194
    .local v8, "rd":Ljava/io/BufferedReader;
    const/4 v9, 0x0

    .line 198
    .local v9, "clsName":Ljava/lang/String;
    :cond_4
    :try_start_4
    invoke-virtual {v8}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v10

    move-object v11, v10

    .local v11, "line":Ljava/lang/String;
    if-eqz v10, :cond_5

    .line 199
    invoke-virtual {v11}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v10

    move-object v11, v10

    .line 200
    invoke-virtual {v11}, Ljava/lang/String;->length()I

    move-result v10

    if-lez v10, :cond_4

    const/4 v10, 0x0

    invoke-virtual {v11, v10}, Ljava/lang/String;->charAt(I)C

    move-result v10
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    const/16 v12, 0x23

    if-eq v10, v12, :cond_4

    .line 201
    move-object v9, v11

    .line 202
    nop

    .line 206
    :cond_5
    :try_start_5
    invoke-virtual {v8}, Ljava/io/BufferedReader;->close()V

    .line 207
    nop

    .line 208
    if-eqz v9, :cond_6

    invoke-virtual {v9}, Ljava/lang/String;->length()I

    move-result v10

    if-lez v10, :cond_6

    .line 209
    invoke-static {p1, v9}, Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;->createNewInstance(Ljava/lang/ClassLoader;Ljava/lang/String;)Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;

    move-result-object v1

    return-object v1

    .line 211
    .end local v6    # "url":Ljava/net/URL;
    .end local v7    # "is":Ljava/io/InputStream;
    .end local v8    # "rd":Ljava/io/BufferedReader;
    .end local v9    # "clsName":Ljava/lang/String;
    .end local v11    # "line":Ljava/lang/String;
    :cond_6
    goto :goto_4

    .line 206
    .restart local v6    # "url":Ljava/net/URL;
    .restart local v7    # "is":Ljava/io/InputStream;
    .restart local v8    # "rd":Ljava/io/BufferedReader;
    .restart local v9    # "clsName":Ljava/lang/String;
    :catchall_0
    move-exception v10

    invoke-virtual {v8}, Ljava/io/BufferedReader;->close()V

    .line 207
    nop

    .end local v0    # "internalId":Ljava/lang/String;
    .end local v2    # "propertyId":Ljava/lang/String;
    .end local v3    # "secEx":Ljava/lang/SecurityException;
    .end local v4    # "path":Ljava/lang/String;
    .end local p0    # "schemaType":Ljava/lang/String;
    .end local p1    # "classLoader":Ljava/lang/ClassLoader;
    throw v10
    :try_end_5
    .catch Ljava/lang/SecurityException; {:try_start_5 .. :try_end_5} :catch_4
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_3

    .line 215
    .end local v5    # "en":Ljava/util/Enumeration;, "Ljava/util/Enumeration<*>;"
    .end local v6    # "url":Ljava/net/URL;
    .end local v7    # "is":Ljava/io/InputStream;
    .end local v8    # "rd":Ljava/io/BufferedReader;
    .end local v9    # "clsName":Ljava/lang/String;
    .restart local v0    # "internalId":Ljava/lang/String;
    .restart local v2    # "propertyId":Ljava/lang/String;
    .restart local v3    # "secEx":Ljava/lang/SecurityException;
    .restart local v4    # "path":Ljava/lang/String;
    .restart local p0    # "schemaType":Ljava/lang/String;
    .restart local p1    # "classLoader":Ljava/lang/ClassLoader;
    :catch_3
    move-exception v5

    goto :goto_5

    .line 213
    :catch_4
    move-exception v5

    .line 214
    .local v5, "se":Ljava/lang/SecurityException;
    move-object v3, v5

    .line 218
    .end local v5    # "se":Ljava/lang/SecurityException;
    :cond_7
    nop

    .line 220
    :goto_5
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "No XMLValidationSchemaFactory implementation class specified or accessible (via system property \'"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "\', or service definition under \'"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 223
    .local v1, "msg":Ljava/lang/String;
    if-eqz v3, :cond_8

    .line 224
    new-instance v5, Ljavax/xml/stream/FactoryConfigurationError;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " (possibly caused by: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ")"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6, v3}, Ljavax/xml/stream/FactoryConfigurationError;-><init>(Ljava/lang/String;Ljava/lang/Exception;)V

    throw v5

    .line 226
    :cond_8
    new-instance v5, Ljavax/xml/stream/FactoryConfigurationError;

    invoke-direct {v5, v1}, Ljavax/xml/stream/FactoryConfigurationError;-><init>(Ljava/lang/String;)V

    throw v5

    .line 128
    .end local v1    # "msg":Ljava/lang/String;
    .end local v2    # "propertyId":Ljava/lang/String;
    .end local v3    # "secEx":Ljava/lang/SecurityException;
    .end local v4    # "path":Ljava/lang/String;
    :cond_9
    new-instance v2, Ljavax/xml/stream/FactoryConfigurationError;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Unrecognized schema type (id \'"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljavax/xml/stream/FactoryConfigurationError;-><init>(Ljava/lang/String;)V

    throw v2
.end method


# virtual methods
.method public abstract createSchema(Ljava/io/File;)Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public createSchema(Ljava/io/InputStream;)Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .locals 1
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 234
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;->createSchema(Ljava/io/InputStream;Ljava/lang/String;)Lorg/codehaus/stax2/validation/XMLValidationSchema;

    move-result-object v0

    return-object v0
.end method

.method public createSchema(Ljava/io/InputStream;Ljava/lang/String;)Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .locals 1
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "encoding"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 240
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0, v0}, Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;->createSchema(Ljava/io/InputStream;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/validation/XMLValidationSchema;

    move-result-object v0

    return-object v0
.end method

.method public abstract createSchema(Ljava/io/InputStream;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public createSchema(Ljava/io/Reader;)Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .locals 1
    .param p1, "r"    # Ljava/io/Reader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 250
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0, v0}, Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;->createSchema(Ljava/io/Reader;Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/validation/XMLValidationSchema;

    move-result-object v0

    return-object v0
.end method

.method public abstract createSchema(Ljava/io/Reader;Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract createSchema(Ljava/net/URL;)Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract getProperty(Ljava/lang/String;)Ljava/lang/Object;
.end method

.method public final getSchemaType()Ljava/lang/String;
    .locals 1

    .line 287
    iget-object v0, p0, Lorg/codehaus/stax2/validation/XMLValidationSchemaFactory;->mSchemaType:Ljava/lang/String;

    return-object v0
.end method

.method public abstract isPropertySupported(Ljava/lang/String;)Z
.end method

.method public abstract setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
.end method
