.class public Lio/minio/messages/InputSerialization;
.super Ljava/lang/Object;
.source "InputSerialization.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "InputSerialization"
.end annotation


# instance fields
.field private compressionType:Lio/minio/messages/CompressionType;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "CompressionType"
        required = false
    .end annotation
.end field

.field private csv:Lio/minio/messages/CsvInputSerialization;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "CSV"
        required = false
    .end annotation
.end field

.field private json:Lio/minio/messages/JsonInputSerialization;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "JSON"
        required = false
    .end annotation
.end field

.field private parquet:Lio/minio/messages/ParquetInputSerialization;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Parquet"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 67
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 68
    new-instance v0, Lio/minio/messages/ParquetInputSerialization;

    invoke-direct {v0}, Lio/minio/messages/ParquetInputSerialization;-><init>()V

    iput-object v0, p0, Lio/minio/messages/InputSerialization;->parquet:Lio/minio/messages/ParquetInputSerialization;

    .line 69
    return-void
.end method

.method public constructor <init>(Lio/minio/messages/CompressionType;Lio/minio/messages/JsonType;)V
    .locals 1
    .param p1, "compressionType"    # Lio/minio/messages/CompressionType;
    .param p2, "type"    # Lio/minio/messages/JsonType;

    .line 61
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 62
    iput-object p1, p0, Lio/minio/messages/InputSerialization;->compressionType:Lio/minio/messages/CompressionType;

    .line 63
    new-instance v0, Lio/minio/messages/JsonInputSerialization;

    invoke-direct {v0, p2}, Lio/minio/messages/JsonInputSerialization;-><init>(Lio/minio/messages/JsonType;)V

    iput-object v0, p0, Lio/minio/messages/InputSerialization;->json:Lio/minio/messages/JsonInputSerialization;

    .line 64
    return-void
.end method

.method public constructor <init>(Lio/minio/messages/CompressionType;ZLjava/lang/Character;Ljava/lang/Character;Lio/minio/messages/FileHeaderInfo;Ljava/lang/Character;Ljava/lang/Character;Ljava/lang/Character;)V
    .locals 11
    .param p1, "compressionType"    # Lio/minio/messages/CompressionType;
    .param p2, "allowQuotedRecordDelimiter"    # Z
    .param p3, "comments"    # Ljava/lang/Character;
    .param p4, "fieldDelimiter"    # Ljava/lang/Character;
    .param p5, "fileHeaderInfo"    # Lio/minio/messages/FileHeaderInfo;
    .param p6, "quoteCharacter"    # Ljava/lang/Character;
    .param p7, "quoteEscapeCharacter"    # Ljava/lang/Character;
    .param p8, "recordDelimiter"    # Ljava/lang/Character;

    .line 47
    move-object v0, p0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 48
    move-object v1, p1

    iput-object v1, v0, Lio/minio/messages/InputSerialization;->compressionType:Lio/minio/messages/CompressionType;

    .line 49
    new-instance v10, Lio/minio/messages/CsvInputSerialization;

    move-object v2, v10

    move v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object/from16 v6, p5

    move-object/from16 v7, p6

    move-object/from16 v8, p7

    move-object/from16 v9, p8

    invoke-direct/range {v2 .. v9}, Lio/minio/messages/CsvInputSerialization;-><init>(ZLjava/lang/Character;Ljava/lang/Character;Lio/minio/messages/FileHeaderInfo;Ljava/lang/Character;Ljava/lang/Character;Ljava/lang/Character;)V

    iput-object v10, v0, Lio/minio/messages/InputSerialization;->csv:Lio/minio/messages/CsvInputSerialization;

    .line 58
    return-void
.end method
