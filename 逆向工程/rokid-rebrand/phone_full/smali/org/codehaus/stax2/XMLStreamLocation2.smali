.class public interface abstract Lorg/codehaus/stax2/XMLStreamLocation2;
.super Ljava/lang/Object;
.source "XMLStreamLocation2.java"

# interfaces
.implements Ljavax/xml/stream/Location;


# static fields
.field public static final NOT_AVAILABLE:Lorg/codehaus/stax2/XMLStreamLocation2;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 16
    new-instance v0, Lorg/codehaus/stax2/XMLStreamLocation2$1;

    invoke-direct {v0}, Lorg/codehaus/stax2/XMLStreamLocation2$1;-><init>()V

    sput-object v0, Lorg/codehaus/stax2/XMLStreamLocation2;->NOT_AVAILABLE:Lorg/codehaus/stax2/XMLStreamLocation2;

    return-void
.end method


# virtual methods
.method public abstract getContext()Lorg/codehaus/stax2/XMLStreamLocation2;
.end method
