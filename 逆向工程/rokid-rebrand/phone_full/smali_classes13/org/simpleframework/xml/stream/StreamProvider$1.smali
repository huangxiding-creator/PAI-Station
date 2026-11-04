.class Lorg/simpleframework/xml/stream/StreamProvider$1;
.super Ljava/lang/Object;
.source "StreamProvider.java"

# interfaces
.implements Ljavax/xml/stream/XMLResolver;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/simpleframework/xml/stream/StreamProvider;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/simpleframework/xml/stream/StreamProvider;


# direct methods
.method constructor <init>(Lorg/simpleframework/xml/stream/StreamProvider;)V
    .locals 0
    .param p1, "this$0"    # Lorg/simpleframework/xml/stream/StreamProvider;

    .line 64
    iput-object p1, p0, Lorg/simpleframework/xml/stream/StreamProvider$1;->this$0:Lorg/simpleframework/xml/stream/StreamProvider;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public resolveEntity(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;
    .locals 2
    .param p1, "publicID"    # Ljava/lang/String;
    .param p2, "systemID"    # Ljava/lang/String;
    .param p3, "baseURI"    # Ljava/lang/String;
    .param p4, "namespace"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 68
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    const-string v1, "Entity resolution disabled for default stream provider constructor."

    invoke-direct {v0, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
