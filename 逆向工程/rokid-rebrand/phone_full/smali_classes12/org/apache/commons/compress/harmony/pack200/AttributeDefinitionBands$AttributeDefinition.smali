.class public Lorg/apache/commons/compress/harmony/pack200/AttributeDefinitionBands$AttributeDefinition;
.super Ljava/lang/Object;
.source "AttributeDefinitionBands.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/apache/commons/compress/harmony/pack200/AttributeDefinitionBands;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "AttributeDefinition"
.end annotation


# instance fields
.field public contextType:I

.field public index:I

.field public layout:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

.field public name:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;


# direct methods
.method public constructor <init>(IILorg/apache/commons/compress/harmony/pack200/CPUTF8;Lorg/apache/commons/compress/harmony/pack200/CPUTF8;)V
    .locals 0
    .param p1, "index"    # I
    .param p2, "contextType"    # I
    .param p3, "name"    # Lorg/apache/commons/compress/harmony/pack200/CPUTF8;
    .param p4, "layout"    # Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    .line 229
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 230
    iput p1, p0, Lorg/apache/commons/compress/harmony/pack200/AttributeDefinitionBands$AttributeDefinition;->index:I

    .line 231
    iput p2, p0, Lorg/apache/commons/compress/harmony/pack200/AttributeDefinitionBands$AttributeDefinition;->contextType:I

    .line 232
    iput-object p3, p0, Lorg/apache/commons/compress/harmony/pack200/AttributeDefinitionBands$AttributeDefinition;->name:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    .line 233
    iput-object p4, p0, Lorg/apache/commons/compress/harmony/pack200/AttributeDefinitionBands$AttributeDefinition;->layout:Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    .line 234
    return-void
.end method
