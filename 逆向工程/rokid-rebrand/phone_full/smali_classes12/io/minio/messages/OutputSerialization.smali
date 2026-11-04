.class public Lio/minio/messages/OutputSerialization;
.super Ljava/lang/Object;
.source "OutputSerialization.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "OutputSerialization"
.end annotation


# instance fields
.field private csv:Lio/minio/messages/CsvOutputSerialization;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "CSV"
        required = false
    .end annotation
.end field

.field private json:Lio/minio/messages/JsonOutputSerialization;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "JSON"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/Character;)V
    .locals 1
    .param p1, "recordDelimiter"    # Ljava/lang/Character;

    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 48
    new-instance v0, Lio/minio/messages/JsonOutputSerialization;

    invoke-direct {v0, p1}, Lio/minio/messages/JsonOutputSerialization;-><init>(Ljava/lang/Character;)V

    iput-object v0, p0, Lio/minio/messages/OutputSerialization;->json:Lio/minio/messages/JsonOutputSerialization;

    .line 49
    return-void
.end method

.method public constructor <init>(Ljava/lang/Character;Ljava/lang/Character;Ljava/lang/Character;Lio/minio/messages/QuoteFields;Ljava/lang/Character;)V
    .locals 7
    .param p1, "fieldDelimiter"    # Ljava/lang/Character;
    .param p2, "quoteCharacter"    # Ljava/lang/Character;
    .param p3, "quoteEscapeCharacter"    # Ljava/lang/Character;
    .param p4, "quoteFields"    # Lio/minio/messages/QuoteFields;
    .param p5, "recordDelimiter"    # Ljava/lang/Character;

    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 41
    new-instance v6, Lio/minio/messages/CsvOutputSerialization;

    move-object v0, v6

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    invoke-direct/range {v0 .. v5}, Lio/minio/messages/CsvOutputSerialization;-><init>(Ljava/lang/Character;Ljava/lang/Character;Ljava/lang/Character;Lio/minio/messages/QuoteFields;Ljava/lang/Character;)V

    iput-object v6, p0, Lio/minio/messages/OutputSerialization;->csv:Lio/minio/messages/CsvOutputSerialization;

    .line 44
    return-void
.end method
